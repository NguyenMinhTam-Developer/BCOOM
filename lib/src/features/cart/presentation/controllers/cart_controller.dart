import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/session/session_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/add_product_to_cart_usecase.dart';
import '../../domain/usecases/apply_voucher_usecase.dart';
import '../../domain/usecases/cancel_cart_usecase.dart';
import '../../domain/usecases/confirm_placing_order_usecase.dart';
import '../../domain/usecases/get_cart_info_usecase.dart';
import '../../domain/usecases/get_platform_coupons_usecase.dart';
import '../../domain/usecases/get_seller_coupons_usecase.dart';
import '../../domain/usecases/reset_cart_usecase.dart';
import '../../domain/usecases/select_shipping_address_usecase.dart';
import '../../domain/usecases/update_cart_usecase.dart';
import '../../domain/usecases/update_product_quantity_usecase.dart';
import '../../../address/domain/usecases/get_addresses_usecase.dart';
import '../../../auth/domain/entities/user.dart';

class CartController extends GetxController {
  final GetCartInfoUseCase _getCartInfoUseCase;
  final ConfirmPlacingOrderUseCase _confirmPlacingOrderUseCase;
  final ApplyVoucherUseCase _applyVoucherUseCase;
  final SelectShippingAddressUseCase _selectShippingAddressUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final CancelCartUseCase _cancelCartUseCase;
  final ResetCartUseCase _resetCartUseCase;
  final GetPlatformCouponsUseCase _getPlatformCouponsUseCase;
  final GetSellerCouponsUseCase _getSellerCouponsUseCase;
  final UpdateCartUseCase _updateCartUseCase;
  final UpdateProductQuantityUseCase _updateProductQuantityUseCase;
  final GetAddressesUseCase _getAddressesUseCase;

  CartController({
    required GetCartInfoUseCase getCartInfoUseCase,
    required ConfirmPlacingOrderUseCase confirmPlacingOrderUseCase,
    required ApplyVoucherUseCase applyVoucherUseCase,
    required SelectShippingAddressUseCase selectShippingAddressUseCase,
    required AddProductToCartUseCase addProductToCartUseCase,
    required CancelCartUseCase cancelCartUseCase,
    required ResetCartUseCase resetCartUseCase,
    required GetPlatformCouponsUseCase getPlatformCouponsUseCase,
    required GetSellerCouponsUseCase getSellerCouponsUseCase,
        required UpdateCartUseCase updateCartUseCase,
        required UpdateProductQuantityUseCase updateProductQuantityUseCase,
        required GetAddressesUseCase getAddressesUseCase,
  })  : _getCartInfoUseCase = getCartInfoUseCase,
        _confirmPlacingOrderUseCase = confirmPlacingOrderUseCase,
        _applyVoucherUseCase = applyVoucherUseCase,
        _selectShippingAddressUseCase = selectShippingAddressUseCase,
        _addProductToCartUseCase = addProductToCartUseCase,
        _cancelCartUseCase = cancelCartUseCase,
        _resetCartUseCase = resetCartUseCase,
        _getPlatformCouponsUseCase = getPlatformCouponsUseCase,
        _getSellerCouponsUseCase = getSellerCouponsUseCase,
        _updateCartUseCase = updateCartUseCase,
        _updateProductQuantityUseCase = updateProductQuantityUseCase,
        _getAddressesUseCase = getAddressesUseCase;

  final RxBool isLoading = false.obs;
  final Rx<CartInfoEntity?> cartInfo = Rx<CartInfoEntity?>(null);
  final Rx<CartOrderEntity?> lastOrder = Rx<CartOrderEntity?>(null);
  bool _hasLoadedDefaultAddress = false;

  bool _isUserVerified(UserEntity? user) => user?.emailVerifiedAt != null;

  void _clearCartState() {
    cartInfo.value = null;
    lastOrder.value = null;

    selectedProductIds.clear();
    sellerSelectionState.clear();
    sellerNotes.clear();
    onePointsUsed.value = 0;
    useOnePoint.value = false;

    platformCoupons.value = null;
    sellerCoupons.clear();

    _hasLoadedDefaultAddress = false;
  }

  // Checkout state
  final RxString selectedPaymentMethod = 'cod'.obs; // Default to COD
  final RxString selectedShippingMethod = 'economy'.obs; // 'economy' or 'express'
  final RxBool useOnePoint = false.obs;
  final RxInt onePointsUsed = 0.obs;
  final RxMap<int, String> sellerNotes = <int, String>{}.obs;

  // Selection state
  final RxSet<int> selectedProductIds = <int>{}.obs;
  final RxMap<int, bool> sellerSelectionState = <int, bool>{}.obs; // sellerId -> isSelected

  // Coupons
  final Rx<PlatformCouponsEntity?> platformCoupons = Rx<PlatformCouponsEntity?>(null);
  final RxMap<int, SellerCouponsEntity> sellerCoupons = <int, SellerCouponsEntity>{}.obs; // sellerId -> coupons

  @override
  Future<void> onInit() async {
    super.onInit();

    final sessionService = Get.find<SessionService>();
    if (_isUserVerified(sessionService.currentUser.value)) {
      await loadCartInfo();
    } else {
      _clearCartState();
    }

    // Load cart only after user becomes verified (e.g. after OTP success)
    ever<UserEntity?>(sessionService.currentUser, (user) {
      if (_isUserVerified(user)) {
        loadCartInfo();
      } else {
        _clearCartState();
      }
    });
  }

  // Selection methods
  bool isProductSelected(int productId) => selectedProductIds.contains(productId);

  void toggleProductSelection(int productId) {
    if (selectedProductIds.contains(productId)) {
      selectedProductIds.remove(productId);
    } else {
      selectedProductIds.add(productId);
    }
    _updateSellerSelectionState();
    _updatePaymentInfoAndCoupons();
  }

  bool isAllSelected() {
    if (cartInfo.value == null || cartInfo.value!.products.isEmpty) return false;
    return selectedProductIds.length == cartInfo.value!.products.length;
  }

  void toggleSelectAll() {
    if (cartInfo.value == null) return;

    if (isAllSelected()) {
      selectedProductIds.clear();
    } else {
      selectedProductIds.addAll(cartInfo.value!.products.map((p) => p.id));
    }
    _updateSellerSelectionState();
    _updatePaymentInfoAndCoupons();
  }

  void _updateSellerSelectionState() {
    if (cartInfo.value == null) return;

    final Map<int, List<CartProductEntity>> productsBySeller = {};
    for (var product in cartInfo.value!.products) {
      if (!productsBySeller.containsKey(product.sellerId)) {
        productsBySeller[product.sellerId] = [];
      }
      productsBySeller[product.sellerId]!.add(product);
    }

    sellerSelectionState.clear();
    for (var entry in productsBySeller.entries) {
      final sellerId = entry.key;
      final products = entry.value;
      final allSelected = products.every((p) => selectedProductIds.contains(p.id));
      sellerSelectionState[sellerId] = allSelected;
    }
  }

  bool isSellerAllSelected(int sellerId) {
    return sellerSelectionState[sellerId] ?? false;
  }

  void toggleSellerSelection(int sellerId) {
    if (cartInfo.value == null) return;

    final sellerProducts = cartInfo.value!.products.where((p) => p.sellerId == sellerId).toList();
    final allSelected = sellerProducts.every((p) => selectedProductIds.contains(p.id));

    if (allSelected) {
      for (var product in sellerProducts) {
        selectedProductIds.remove(product.id);
      }
    } else {
      for (var product in sellerProducts) {
        selectedProductIds.add(product.id);
      }
    }
    _updateSellerSelectionState();
    _updatePaymentInfoAndCoupons();
  }

  void addToFavorites(int productId) {
    // TODO: Implement add to favorites
    Get.snackbar('Thông báo', 'Đã thêm vào yêu thích');
  }

  Future<void> deleteProduct(int productId) async {
    if (cartInfo.value == null) return;

    final product = cartInfo.value!.products.firstWhereOrNull((p) => p.id == productId);
    if (product == null) return;

    isLoading.value = true;

    // Build products array with all current products, excluding the one to delete
    final products = cartInfo.value!.products
        .where((p) => p.id != productId)
        .map((p) => {
              'id': p.id,
              'variant_id': p.variantId,
              'quantity': p.quantity,
            })
        .toList();

    final result = await _updateCartUseCase(
      UpdateCartParams(products: products),
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
      (entity) {
        cartInfo.value = entity;
        // Remove from selection if it was selected
        selectedProductIds.remove(productId);
        _updateSellerSelectionState();
        _updatePaymentInfoAndCoupons();
        Get.snackbar(
          'Thành công',
          'Đã xóa sản phẩm',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      },
    );

    isLoading.value = false;
  }

  Future<void> deleteAllSelected() async {
    if (cartInfo.value == null || cartInfo.value!.products.isEmpty) return;

    isLoading.value = true;
    final result = await _resetCartUseCase(NoParams());

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
      (_) {
        // Clear selection state
        selectedProductIds.clear();
        sellerSelectionState.clear();
        sellerCoupons.clear();

        // Refresh cart data
        loadCartInfo();

        Get.snackbar(
          'Thành công',
          'Đã xóa tất cả sản phẩm',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      },
    );

    isLoading.value = false;
  }

  Future<void> updateProductQuantity(int productId, int quantity) async {
    if (cartInfo.value == null) return;

    // Ensure quantity is at least 0
    if (quantity < 0) quantity = 0;

    final product = cartInfo.value!.products.firstWhereOrNull((p) => p.id == productId);
    if (product == null) return;

    isLoading.value = true;

    // If quantity is 0, use updateCart to remove the product
    if (quantity == 0) {
      // Build products array excluding the product to delete
      final products = cartInfo.value!.products
          .where((p) => p.id != productId)
          .map((p) => {
                'id': p.id,
                'variant_id': p.variantId,
                'quantity': p.quantity,
              })
          .toList();

      final result = await _updateCartUseCase(
        UpdateCartParams(products: products),
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
        (entity) {
          cartInfo.value = entity;
          selectedProductIds.remove(productId);
          _updateSellerSelectionState();
          _updatePaymentInfoAndCoupons();
        },
      );
    } else {
      // Use updateProductQuantity for non-zero quantities
      final result = await _updateProductQuantityUseCase(
        UpdateProductQuantityParams(
          productId: productId,
          variantId: product.variantId,
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
        (entity) {
          cartInfo.value = entity;
          _updateSellerSelectionState();
          _updatePaymentInfoAndCoupons();
        },
      );
    }

    isLoading.value = false;
  }

  /// Update payment information and fetch coupons for selected products
  Future<void> _updatePaymentInfoAndCoupons() async {
    // Fetch coupons for all stores whenever selection changes
    _fetchCouponsForAllStores();
  }

  /// Fetch coupons for all stores with products (regardless of selection)
  Future<void> _fetchCouponsForAllStores() async {
    if (cartInfo.value == null) return;

    // Group all products by seller (not just selected)
    final Map<int, List<CartProductEntity>> productsBySeller = {};

    for (var product in cartInfo.value!.products) {
      if (!productsBySeller.containsKey(product.sellerId)) {
        productsBySeller[product.sellerId] = [];
      }
      productsBySeller[product.sellerId]!.add(product);
    }

    // Fetch seller coupons for each seller
    for (var entry in productsBySeller.entries) {
      final sellerId = entry.key;
      final products = entry.value;

      // Get selected products for this seller
      final selectedProducts = products.where((p) => selectedProductIds.contains(p.id)).toList();

      // Calculate total based on selected products
      num totalProduct = 0;
      final List<int> productIds = [];

      for (var product in selectedProducts) {
        // Get the actual price (variant price if variant is selected)
        num price = product.priceSale;
        if (product.variantId > 0 && product.variants.isNotEmpty) {
          try {
            final variant = product.variants.firstWhere((v) => v.id == product.variantId);
            price = variant.priceSale;
          } catch (e) {
            // Keep product price if variant not found
          }
        }

        totalProduct += price * product.quantity;
        productIds.add(product.id);
      }

      // Only fetch if there are selected products for this seller
      if (productIds.isNotEmpty) {
        _fetchSellerCoupons(
          sellerId: sellerId,
          totalProduct: totalProduct.toInt(),
          productIds: productIds,
        );
      }
    }
  }

  /// Fetch seller coupons for a specific seller
  Future<void> _fetchSellerCoupons({
    required int sellerId,
    required int totalProduct,
    required List<int> productIds,
  }) async {
    final result = await _getSellerCouponsUseCase(
      GetSellerCouponsParams(
        sellerId: sellerId,
        totalProduct: totalProduct,
        productIds: productIds,
      ),
    );

    result.fold(
      (failure) {
        // Silently fail - coupons are optional
      },
      (coupons) {
        sellerCoupons[sellerId] = coupons;
      },
    );
  }

  /// Fetch platform coupons
  Future<void> fetchPlatformCoupons() async {
    final result = await _getPlatformCouponsUseCase(NoParams());

    result.fold(
      (failure) {
        // Silently fail - coupons are optional
      },
      (coupons) {
        platformCoupons.value = coupons;
      },
    );
  }

  /// Calculate total for selected products
  num getSelectedProductsTotal() {
    if (cartInfo.value == null) return 0;

    num total = 0;
    for (var productId in selectedProductIds) {
      final product = cartInfo.value!.products.firstWhereOrNull((p) => p.id == productId);
      if (product != null) {
        // Get the actual price (variant price if variant is selected)
        num price = product.priceSale;

        // If variant is selected, use variant price
        if (product.variantId > 0 && product.variants.isNotEmpty) {
          try {
            final variant = product.variants.firstWhere((v) => v.id == product.variantId);
            price = variant.priceSale;
          } catch (e) {
            // Keep product price if variant not found
          }
        }

        total += price * product.quantity;
      }
    }
    return total;
  }

  /// Get count of selected products
  int getSelectedProductsCount() {
    return selectedProductIds.length;
  }

  /// Get selected products grouped by seller
  Map<int, List<CartProductEntity>> getSelectedProductsBySeller() {
    if (cartInfo.value == null) return {};

    final Map<int, List<CartProductEntity>> result = {};
    for (var productId in selectedProductIds) {
      final product = cartInfo.value!.products.firstWhereOrNull((p) => p.id == productId);
      if (product != null) {
        if (!result.containsKey(product.sellerId)) {
          result[product.sellerId] = [];
        }
        result[product.sellerId]!.add(product);
      }
    }
    return result;
  }

  Future<void> loadCartInfo() async {
    final sessionService = Get.find<SessionService>();
    if (!_isUserVerified(sessionService.currentUser.value)) {
      isLoading.value = false;
      _clearCartState();
      return;
    }

    isLoading.value = true;
    final result = await _getCartInfoUseCase(NoParams());
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        cartInfo.value = entity;
        // Select all products by default on initial load
        if (selectedProductIds.isEmpty) {
          selectedProductIds.addAll(entity.products.map((p) => p.id));
        }
        _updateSellerSelectionState();
        // Fetch coupons for all stores with products
        _fetchCouponsForAllStores();
      },
    );
    isLoading.value = false;
  }

  Future<void> confirmPlacingOrder({
    required List<Map<String, int>> products,
    String? remarks,
    int hasExportEinvoice = 0,
    required String paymentMethod,
    required Map<String, String> shippingAddress,
    dynamic einvoice,
  }) async {
    isLoading.value = true;
    final result = await _confirmPlacingOrderUseCase(
      ConfirmPlacingOrderParams(
        products: products,
        remarks: remarks,
        hasExportEinvoice: hasExportEinvoice,
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
        einvoice: einvoice,
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (order) {
        lastOrder.value = order;
        // Clear cart after successful order
        cartInfo.value = null;
        Get.snackbar('Thành công', 'Đặt hàng thành công');
      },
    );
    isLoading.value = false;
  }

  Future<void> applyVoucher(String voucherCode) async {
    isLoading.value = true;
    final result = await _applyVoucherUseCase(
      ApplyVoucherParams(voucherCode: voucherCode),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        cartInfo.value = entity;
        Get.snackbar('Thành công', 'Áp dụng mã giảm giá thành công');
      },
    );
    isLoading.value = false;
  }

  Future<void> selectShippingAddress(int addressId) async {
    isLoading.value = true;
    final result = await _selectShippingAddressUseCase(
      SelectShippingAddressParams(addressId: addressId),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        cartInfo.value = entity;
        Get.snackbar('Thành công', 'Chọn địa chỉ giao hàng thành công');
      },
    );
    isLoading.value = false;
  }

  /// Load addresses and select the default address (isDefault = true)
  /// If no default address exists, no address will be selected
  /// This method will only run once per controller instance
  Future<void> loadAndSelectDefaultAddress() async {
    // Only load once
    if (_hasLoadedDefaultAddress) return;

    _hasLoadedDefaultAddress = true;

    final result = await _getAddressesUseCase(NoParams());
    result.fold(
      (failure) {
        // Silently fail - address loading is optional
        _hasLoadedDefaultAddress = false; // Reset on failure so it can retry
      },
      (addressList) {
        // Find address with isDefault = true (value = 1 in API)
        final defaultAddress = addressList.addresses.firstWhereOrNull(
          (address) => address.isDefault == true,
        );

        if (defaultAddress != null) {
          // Select the default address (without showing snackbar)
          selectShippingAddressSilently(defaultAddress.id);
        }
        // If no default address, do nothing (no address selected)
      },
    );
  }

  /// Select shipping address without showing success message
  Future<void> selectShippingAddressSilently(int addressId) async {
    final result = await _selectShippingAddressUseCase(
      SelectShippingAddressParams(addressId: addressId),
    );
    result.fold(
      (failure) {
        // Silently fail
        _hasLoadedDefaultAddress = false; // Reset on failure so it can retry
      },
      (entity) {
        cartInfo.value = entity;
      },
    );
  }

  Future<void> addProductToCart({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    isLoading.value = true;
    final result = await _addProductToCartUseCase(
      AddProductToCartParams(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        cartInfo.value = entity;
        Get.snackbar('Thành công', 'Thêm sản phẩm vào giỏ hàng thành công');
      },
    );
    isLoading.value = false;
  }

  Future<void> cancelCart() async {
    isLoading.value = true;
    final result = await _cancelCartUseCase(NoParams());
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (_) {
        cartInfo.value = null;
        Get.snackbar('Thành công', 'Hủy giỏ hàng thành công');
      },
    );
    isLoading.value = false;
  }
}
