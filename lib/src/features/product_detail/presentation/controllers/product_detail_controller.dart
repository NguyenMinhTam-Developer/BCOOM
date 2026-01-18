// product_detail_controller.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/entities/product_detail_entity.dart';
import '../../domain/entities/related_products_entity.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_related_products_usecase.dart';
import '../../models/recommended_product.dart';
import '../widgets/product_gallery_dialog.dart';
import '../../../cart/domain/usecases/add_product_to_cart_usecase.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';

class ProductDetailController extends GetxController with GetTickerProviderStateMixin {
  final GetProductDetailUseCase getProductDetailUseCase;
  final GetRelatedProductsUseCase getRelatedProductsUseCase;
  final AddProductToCartUseCase? addProductToCartUseCase;

  ProductDetailController({
    required this.getProductDetailUseCase,
    required this.getRelatedProductsUseCase,
    this.addProductToCartUseCase,
  });

  // UI state
  final Rx<ProductDetailEntity?> productDetailEntity = Rx<ProductDetailEntity?>(null);
  final Rx<RelatedProductsEntity?> relatedProducts = Rx<RelatedProductsEntity?>(null);
  final RxList<RecommendedProduct> recommendedProducts = RecommendedProduct.sampleProducts.obs;
  final RxInt currentImageIndex = 0.obs;
  final RxInt selectedProductId = 0.obs; // Selected product/variant ID (main product by default)
  final RxBool isFavorite = false.obs;
  final RxBool isDescriptionExpanded = false.obs;
  final RxBool isSubDescriptionExpanded = false.obs;
  final RxBool isConfigurationExpanded = false.obs;
  final RxBool isLoading = true.obs;
  final Rx<String?> errorMessage = Rx<String?>(null);

  // Image to product mapping (maps image index to product/variant ID)
  final RxList<int> imageToProductMap = <int>[].obs;

  // First sticky header tabs: 0 = Mô tả sản phẩm, 1 = Chi tiết sản phẩm, 2 = Hướng dẫn sử dụng, 3 = Đánh giá
  final RxInt selectedFirstTabIndex = 0.obs;
  static const List<String> firstTabLabels = ['Mô tả sản phẩm', 'Chi tiết sản phẩm', 'Hướng dẫn sử dụng', 'Đánh giá'];

  // Second sticky header tabs: 0 = Sản phẩm cùng thương hiệu, 1 = Sản phẩm cùng danh mục, 2 = Sản phẩm cùng nhà bán lẻ
  final RxInt selectedSecondTabIndex = 0.obs;
  static const List<String> secondTabLabels = ['Sản phẩm cùng thương hiệu', 'Sản phẩm cùng danh mục', 'Sản phẩm cùng nhà bán lẻ'];

  // Keys & scroll controller (set by page)
  GlobalKey? descriptionSectionKey; // Mô tả sản phẩm
  GlobalKey? detailSectionKey; // Chi tiết sản phẩm
  GlobalKey? configurationSectionKey; // Hướng dẫn sử dụng
  GlobalKey? reviewSectionKey; // Đánh giá
  GlobalKey? relatedProductsSectionKey; // Second sticky header section
  ScrollController? _scrollController;
  int _scrollControllerGeneration = 0;

  // Getter/setter for scrollController with generation tracking
  ScrollController? get scrollController => _scrollController;
  set scrollController(ScrollController? value) {
    if (value != null) {
      _scrollControllerGeneration++;
    }
    _scrollController = value;
  }

  // Programmatic scroll flag (prevent feedback loop)
  bool _isProgrammaticScroll = false;

  // Track current scroll position (workaround for scrollController.offset returning 0)
  double _currentScrollOffset = 0.0;

  // Calculated offsets
  final List<double> sectionOffsets = [];

  // TabBar height used when calculating final scroll target
  static double get tabBarHeight => 48.h;

  // SliverAppBar sizes
  static double get expandedHeight => 375.h;
  static double get collapsedHeight => 56.h;

  // internal retry counter for offset calc
  int _offsetCalcAttempts = 0;

  // Animation controllers
  late final PageController pageController;
  late final AnimationController headerAnimationController;
  late final AnimationController descriptionAnimationController;

  // Tab controllers for TabBar widgets
  late final TabController firstTabController;
  late final TabController secondTabController;

  @override
  void onInit() {
    super.onInit();
    _initControllers();
    _loadProductDetail();
    _loadRelatedProducts();
  }

  Future<void> _loadProductDetail() async {
    // Get name_slug from route parameters
    final nameSlug = Get.parameters['name_slug'];
    if (nameSlug == null || nameSlug.isEmpty) {
      errorMessage.value = 'Không tìm thấy sản phẩm';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final result = await getProductDetailUseCase(
      GetProductDetailParams(nameSlug: nameSlug),
    );

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      },
      (entity) {
        productDetailEntity.value = entity;
        _initDefaultSelections();
        _buildImageToProductMap();
        isLoading.value = false;
      },
    );
  }

  Future<void> _loadRelatedProducts() async {
    // Get name_slug from route parameters
    final nameSlug = Get.parameters['name_slug'];
    if (nameSlug == null || nameSlug.isEmpty) {
      return;
    }

    final result = await getRelatedProductsUseCase(
      GetRelatedProductsParams(nameSlug: nameSlug),
    );

    result.fold(
      (failure) {
        // Silently fail for related products - not critical
      },
      (entity) {
        relatedProducts.value = entity;
      },
    );
  }

  void _initControllers() {
    pageController = PageController();
    headerAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    descriptionAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    firstTabController = TabController(length: firstTabLabels.length, vsync: this, initialIndex: 0);
    secondTabController = TabController(length: secondTabLabels.length, vsync: this, initialIndex: 0);

    // Sync TabController with reactive state (when user taps tab)
    firstTabController.addListener(() {
      if (!firstTabController.indexIsChanging && firstTabController.index != selectedFirstTabIndex.value) {
        selectedFirstTabIndex.value = firstTabController.index;
      }
    });

    secondTabController.addListener(() {
      if (!secondTabController.indexIsChanging && secondTabController.index != selectedSecondTabIndex.value) {
        selectedSecondTabIndex.value = secondTabController.index;
      }
    });
  }

  void _initDefaultSelections() {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    // Initialize with main product ID
    selectedProductId.value = entity.id;
    isFavorite.value = false;
  }

  /// Build a mapping from image index to product/variant ID
  void _buildImageToProductMap() {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    imageToProductMap.clear();

    // Add main product images
    if (entity.productImages.isNotEmpty) {
      for (var i = 0; i < entity.productImages.length; i++) {
        imageToProductMap.add(entity.id);
      }
    } else {
      // Single main product image
      imageToProductMap.add(entity.id);
    }

    // Add variant images
    for (var variant in entity.variants) {
      if (variant.productImages.isNotEmpty) {
        for (var i = 0; i < variant.productImages.length; i++) {
          imageToProductMap.add(variant.id);
        }
      } else {
        // Single variant image (if it exists and is unique)
        final variantImageUrl = '${variant.imageUrl}${variant.imageLocation}';
        if (variantImageUrl.trim().isNotEmpty) {
          // Check if this image is not already in the main product images
          bool isUnique = true;
          if (entity.productImages.isEmpty) {
            final mainImageUrl = '${entity.imageUrl}${entity.imageLocation}';
            if (variantImageUrl == mainImageUrl) {
              isUnique = false;
            }
          }
          if (isUnique) {
            imageToProductMap.add(variant.id);
          }
        }
      }
    }
  }

  // Called on every scroll (from page)
  void onScroll(double offset) {
    // Store the current offset (workaround for scrollController.offset being unreliable)
    final oldOffset = _currentScrollOffset;
    _currentScrollOffset = offset;

    // Log during programmatic scroll to track progress
    if (_isProgrammaticScroll && (offset - oldOffset).abs() > 10) {}

    // update first tab based on offsets only if we have offsets calculated
    if (!_isProgrammaticScroll && sectionOffsets.length == 4) {
      _updateFirstTabIndexFromScroll(offset);
    }
  }

  /// Calculate offsets for the three sections.
  /// This method retries a few times if contexts are not ready.
  void calculateSectionOffsets() {
    // reset attempts if we're starting a fresh calculation
    if (_offsetCalcAttempts == 0) {
      sectionOffsets.clear();
    }

    if (scrollController == null || !scrollController!.hasClients) {
      _retryCalculateOffsets();
      return;
    }

    final double? description = _getSectionTopOffset(descriptionSectionKey);
    final double? detail = _getSectionTopOffset(detailSectionKey);
    final double? configuration = _getSectionTopOffset(configurationSectionKey);
    final double? review = _getSectionTopOffset(reviewSectionKey);

    if (description == null || detail == null || configuration == null || review == null) {
      _retryCalculateOffsets();
      return;
    }

    // Order: [description, detail, configuration, review] to match first tab order
    sectionOffsets
      ..clear()
      ..addAll([description, detail, configuration, review]);

    _offsetCalcAttempts = 0; // reset attempts
  }

  void _retryCalculateOffsets() {
    _offsetCalcAttempts++;
    if (_offsetCalcAttempts > 8) {
      _offsetCalcAttempts = 0;
      return;
    }
    // schedule another attempt on next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateSectionOffsets();
    });
  }

  /// Returns the absolute scroll offset to position the section under the sticky header.
  /// Returns null if calculation cannot be performed.
  double? _getSectionTopOffset(GlobalKey? key) {
    if (key == null || key.currentContext == null || scrollController == null || !scrollController!.hasClients) {
      return null;
    }

    final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    // Get position of section on screen
    final sectionPosition = renderBox.localToGlobal(Offset.zero);

    // Get the scrollable's position on screen
    final scrollableBox = scrollController!.position.context.notificationContext?.findRenderObject() as RenderBox?;
    if (scrollableBox == null) {
      return null;
    }
    final scrollablePosition = scrollableBox.localToGlobal(Offset.zero);

    // Calculate absolute position of section in scrollable content
    // = current scroll offset + (section screen position - scrollable screen position)
    // Use _currentScrollOffset instead of scrollController.offset (which incorrectly returns 0)
    final currentOffset = _currentScrollOffset;
    final sectionOffsetInViewport = sectionPosition.dy - scrollablePosition.dy;
    final absolutePositionInContent = currentOffset + sectionOffsetInViewport;

    // stickyHeader (collapsed appbar + tabbar + statusbar)
    final statusBar = MediaQuery.of(key.currentContext!).padding.top;
    final stickyHeaderHeight = collapsedHeight + tabBarHeight + statusBar;

    // Calculate target scroll offset (position section under sticky header)
    final targetOffset = absolutePositionInContent - stickyHeaderHeight;
    final clamped = targetOffset.clamp(0.0, scrollController!.position.maxScrollExtent);

    return clamped;
  }

  /// Select first sticky header tab and scroll to section
  void selectFirstTab(int index, {ScrollController? activeScrollController}) {
    // If already in a programmatic scroll, ignore this tap
    if (_isProgrammaticScroll) {
      return;
    }

    // Update UI state immediately (TabController will be updated via onTap callback)
    selectedFirstTabIndex.value = index;
    if (firstTabController.index != index) {
      firstTabController.animateTo(index);
    }

    // Don't recalculate - use cached offsets if available
    if (sectionOffsets.length != 4) {
      calculateSectionOffsets();
    }

    // Scroll to the index using cached offsets
    if (sectionOffsets.length == 4 && index < sectionOffsets.length) {
      final targetOffset = sectionOffsets[index];
      final controllerToUse = activeScrollController ?? scrollController;
      if (controllerToUse != null) {
        _performProgrammaticScroll(targetOffset, activeScrollController: controllerToUse);
      }
    } else {
      // schedule a small delay and then try to scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 80), () {
          if (sectionOffsets.length == 4 && index < sectionOffsets.length) {
            final targetOffset = sectionOffsets[index];
            final controllerToUse = activeScrollController ?? scrollController;
            if (controllerToUse != null) {
              _performProgrammaticScroll(targetOffset, activeScrollController: controllerToUse);
            }
          }
        });
      });
    }
  }

  /// Performs the scroll and sets programmatic flag to avoid feedback loop.
  Future<void> _performProgrammaticScroll(double targetOffset, {required ScrollController activeScrollController}) async {
    if (!activeScrollController.hasClients) {
      return;
    }

    final currentPosition = _currentScrollOffset;
    final maxScroll = activeScrollController.position.maxScrollExtent;
    final minScroll = activeScrollController.position.minScrollExtent;
    final clamped = targetOffset.clamp(minScroll, maxScroll);

    if ((currentPosition - clamped).abs() < 1.0) {
      return;
    }

    _isProgrammaticScroll = true;

    try {
      final controllerPixels = activeScrollController.position.pixels;

      // Safety check: if the scrollController's pixels don't match our tracked offset,
      // it means we're using the wrong controller!
      if ((controllerPixels - _currentScrollOffset).abs() > 10.0 && _currentScrollOffset > 0) {
        return;
      }

      // Call animateTo directly
      await activeScrollController.animateTo(
        clamped,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      // give small cooldown so scroll listener doesn't flip tab immediately

      await Future.delayed(const Duration(milliseconds: 180));
      _isProgrammaticScroll = false;
    }
  }

  /// Called by onScroll to update selectedFirstTabIndex based on current scroll offset.
  void _updateFirstTabIndexFromScroll(double scrollOffset) {
    if (sectionOffsets.length != 4) return;

    final description = sectionOffsets[0]; // Mô tả sản phẩm (tab 0)
    final detail = sectionOffsets[1]; // Chi tiết sản phẩm (tab 1)
    final configuration = sectionOffsets[2]; // Hướng dẫn sử dụng (tab 2)
    final review = sectionOffsets[3]; // Đánh giá (tab 3)

    const buffer = 20.0;

    int newIndex;
    if (scrollOffset >= review - buffer) {
      newIndex = 3; // Đánh giá
    } else if (scrollOffset >= configuration - buffer) {
      newIndex = 2; // Hướng dẫn sử dụng
    } else if (scrollOffset >= detail - buffer) {
      newIndex = 1; // Chi tiết sản phẩm
    } else if (scrollOffset >= description - buffer) {
      newIndex = 0; // Mô tả sản phẩm
    } else {
      newIndex = 0; // Mô tả sản phẩm
    }

    if (newIndex != selectedFirstTabIndex.value) {
      selectedFirstTabIndex.value = newIndex;
    }
  }

  // Remaining helper functions and actions
  void onImagePageChanged(int index) {
    currentImageIndex.value = index;

    // Update selectedProductId based on which product/variant owns this image
    if (index < imageToProductMap.length) {
      final productId = imageToProductMap[index];
      if (selectedProductId.value != productId) {
        selectedProductId.value = productId;
      }
    }
  }

  void goToImage(int index) => pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

  /// Toggle variant selection - if already selected, go back to main product
  void toggleVariantSelection(int variantId) {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    if (selectedProductId.value == variantId) {
      // If clicking the same variant, go back to main product
      selectedProductId.value = entity.id;

      _animateToProductImages(entity.id);
    } else {
      // Select the new variant
      selectedProductId.value = variantId;

      _animateToProductImages(variantId);
    }
  }

  /// Animate carousel to the first image of the selected product/variant
  void _animateToProductImages(int productId) {
    if (!pageController.hasClients || imageToProductMap.isEmpty) return;

    // Find the first image index for this product/variant
    final firstImageIndex = imageToProductMap.indexWhere((id) => id == productId);

    if (firstImageIndex != -1 && firstImageIndex != currentImageIndex.value) {
      pageController.animateToPage(
        firstImageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Check if a variant is selected
  bool isVariantSelected(int variantId) {
    return selectedProductId.value == variantId;
  }

  void toggleFavorite() => isFavorite.value = !isFavorite.value;
  void toggleDescription() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
    if (isDescriptionExpanded.value) {
      descriptionAnimationController.forward();
    } else {
      descriptionAnimationController.reverse();
    }
  }

  Future<void> addToCart() async {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    // Check if product has variants
    final hasVariants = entity.variants.isNotEmpty;
    
    // Check if a variant is selected (selectedProductId != entity.id means a variant is selected)
    final isVariantSelected = hasVariants && selectedProductId.value != entity.id;
    
    // If product has variants but none is selected, show error
    if (hasVariants && !isVariantSelected) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng chọn phân loại sản phẩm trước khi thêm vào giỏ hàng',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // If usecase is not available, show error
    if (addProductToCartUseCase == null) {
      Get.snackbar(
        'Lỗi',
        'Không thể thêm sản phẩm vào giỏ hàng',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // Use selectedProductId (which is either the main product ID or variant ID)
    final productId = selectedProductId.value;
    final variantId = isVariantSelected ? selectedProductId.value : 0;
    const quantity = 1; // Default quantity is 1

    // Call the usecase
    final result = await addProductToCartUseCase!(
      AddProductToCartParams(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      ),
    );

    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      },
      (cartInfo) {
        Get.snackbar(
          'Thành công',
          'Đã thêm sản phẩm vào giỏ hàng',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
        // Refresh cart data if CartController is available
        if (Get.isRegistered<CartController>()) {
          Get.find<CartController>().loadCartInfo();
        }
      },
    );
  }

  void openGallery() {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    // Collect all images from product and variants
    final images = <String>[];

    // Add main product images
    if (entity.productImages.isNotEmpty) {
      images.addAll(
        entity.productImages.map(
          (img) => '${img.imageUrl}${img.imageLocation}',
        ),
      );
    } else {
      // Fallback to main product image
      images.add('${entity.imageUrl}${entity.imageLocation}');
    }

    // Add all variant images
    for (var variant in entity.variants) {
      if (variant.productImages.isNotEmpty) {
        images.addAll(
          variant.productImages.map(
            (img) => '${img.imageUrl}${img.imageLocation}',
          ),
        );
      } else {
        // Fallback to variant image
        final variantImageUrl = '${variant.imageUrl}${variant.imageLocation}';
        // Only add if not empty and not already in list
        if (variantImageUrl.trim().isNotEmpty && !images.contains(variantImageUrl)) {
          images.add(variantImageUrl);
        }
      }
    }

    // Remove duplicates while preserving order
    final uniqueImages = images.toSet().toList();

    ProductGalleryDialog.show(images: uniqueImages, initialIndex: currentImageIndex.value);
  }

  Future<void> buyNow() async {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    // Check if product has variants
    final hasVariants = entity.variants.isNotEmpty;
    
    // Check if a variant is selected (selectedProductId != entity.id means a variant is selected)
    final isVariantSelected = hasVariants && selectedProductId.value != entity.id;
    
    // If product has variants but none is selected, show error
    if (hasVariants && !isVariantSelected) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng chọn phân loại sản phẩm trước khi mua',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // If usecase is not available, show error
    if (addProductToCartUseCase == null) {
      Get.snackbar(
        'Lỗi',
        'Không thể thêm sản phẩm vào giỏ hàng',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    // Use selectedProductId (which is either the main product ID or variant ID)
    final productId = selectedProductId.value;
    final variantId = isVariantSelected ? selectedProductId.value : 0;
    const quantity = 1; // Default quantity is 1

    // Call the usecase
    final result = await addProductToCartUseCase!(
      AddProductToCartParams(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      ),
    );

    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      },
      (cartInfo) {
        // Refresh cart data if CartController is available
        if (Get.isRegistered<CartController>()) {
          Get.find<CartController>().loadCartInfo();
        }
        // Navigate to cart page after successfully adding to cart
        Get.toNamed('/cart');
      },
    );
  }

  void goBack() => Get.back();
  void shareProduct() {}
  void goToCart() {
    Get.toNamed('/cart');
  }
  void copyProductLink() {
    Get.snackbar('Đã sao chép', 'Link sản phẩm đã được sao chép vào clipboard', snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
  }

  /// Navigate to product information page with HTML content
  void navigateToProductInfo({required String content, required String title}) {
    final entity = productDetailEntity.value;
    if (entity == null) return;

    Get.toNamed(
      '/product-information',
      arguments: {
        'content': content,
        'title': title,
        'productName': entity.name,
      },
    );
  }

  /// Select second sticky header tab (just switches content, no scrolling)
  void selectSecondTab(int index) {
    selectedSecondTabIndex.value = index;
    if (secondTabController.index != index) {
      secondTabController.animateTo(index);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    headerAnimationController.dispose();
    descriptionAnimationController.dispose();
    firstTabController.dispose();
    secondTabController.dispose();
    super.onClose();
  }
}
