// product_detail_page.dart
import 'dart:async';

import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:bcoom/src/shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../catalog/presentation/pages/product_list_page.dart';
import '../../../search/domain/entities/search_product_entity.dart';
import '../controllers/product_detail_controller.dart';
import '../widgets/variant_selector.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_configuration_info.dart';
import '../widgets/product_description.dart';
import '../widgets/product_first_sticky_tab_bar.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/product_info_section.dart';
import '../widgets/product_second_sticky_tab_bar.dart';
import '../widgets/product_sub_description.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductDetailController controller;
  late final ScrollController _scrollController;

  // Section keys for first sticky header
  final GlobalKey _descriptionSectionKey = GlobalKey(); // Mô tả sản phẩm
  final GlobalKey _detailSectionKey = GlobalKey(); // Chi tiết sản phẩm
  final GlobalKey _configurationSectionKey = GlobalKey(); // Hướng dẫn sử dụng
  final GlobalKey _reviewSectionKey = GlobalKey(); // Đánh giá
  final GlobalKey _relatedProductsSectionKey = GlobalKey(); // Second sticky header section

  Timer? _recalcTimer;

  @override
  void initState() {
    super.initState();

    controller = Get.find<ProductDetailController>();
    _scrollController = ScrollController();

    // Add listener to track scroll offset
    _scrollController.addListener(() {
      controller.onScroll(_scrollController.offset);
    });

    // Assign keys and scrollController to controller IMMEDIATELY (not in postFrameCallback)
    // This prevents issues with double initialization

    controller.descriptionSectionKey = _descriptionSectionKey;
    controller.detailSectionKey = _detailSectionKey;
    controller.configurationSectionKey = _configurationSectionKey;
    controller.reviewSectionKey = _reviewSectionKey;
    controller.relatedProductsSectionKey = _relatedProductsSectionKey;
    controller.scrollController = _scrollController;

    // Calculate offsets after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Immediately try to calculate offsets (controller will retry if not ready)
      controller.calculateSectionOffsets();

      // Also schedule periodic recalculation for a short time in case of async layouts (images, fonts)
      _startTemporaryOffsetRecalc();
    });
  }

  void _startTemporaryOffsetRecalc() {
    // Recalculate offsets a few times in case some slivers finish layout a moment later
    int attempts = 0;
    _recalcTimer?.cancel();
    _recalcTimer = Timer.periodic(const Duration(milliseconds: 150), (t) {
      attempts++;
      controller.calculateSectionOffsets();
      if (attempts >= 8) {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _recalcTimer?.cancel();
    _scrollController.dispose();
    // Clear the reference in controller
    controller.scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Text(
              controller.errorMessage.value!,
              style: AppTextStyles.body14.copyWith(color: AppColors.error500),
            ),
          );
        }

        if (controller.productDetailEntity.value == null) {
          return const SizedBox.shrink();
        }

        final entity = controller.productDetailEntity.value;
        final hasVariants = entity?.variants.isNotEmpty ?? false;

        return CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(context),

            // Only show variant selector if there are variants
            if (hasVariants)
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: const ProductVariantSelector(),
                ),
              ),

            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: const ProductInfoSection(),
              ),
            ),

            // First sticky tab bar
            SliverPersistentHeader(
              pinned: true,
              delegate: ProductFirstStickyTabBarDelegate(),
            ),

            // Mô tả sản phẩm section
            SliverToBoxAdapter(
              child: Container(
                key: _descriptionSectionKey,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h, bottom: 8.h),
                child: const ProductSubDescription(),
              ),
            ),

            // Chi tiết sản phẩm section
            SliverToBoxAdapter(
              child: Container(
                key: _detailSectionKey,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h, bottom: 8.h),
                child: const ProductDescription(),
              ),
            ),

            // Hướng dẫn sử dụng section
            SliverToBoxAdapter(
              child: Container(
                key: _configurationSectionKey,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h, bottom: 8.h),
                child: const ProductConfigurationInfo(),
              ),
            ),

            // Đánh giá section
            SliverToBoxAdapter(
              child: Container(
                key: _reviewSectionKey,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 20.h, bottom: 8.h),
                child: const _ReviewsSection(),
              ),
            ),

            // Second sticky tab bar
            SliverPersistentHeader(
              pinned: true,
              delegate: ProductSecondStickyTabBarDelegate(),
            ),

            // Related products list (switches content based on second tab)
            SliverToBoxAdapter(
              child: Container(
                key: _relatedProductsSectionKey,
                color: Colors.transparent,
                child: Obx(() {
                  final relatedProducts = controller.relatedProducts.value;
                  final selectedIndex = controller.selectedSecondTabIndex.value;

                  if (relatedProducts == null) {
                    return const SizedBox.shrink();
                  }

                  List<SearchProductEntity> products;

                  switch (selectedIndex) {
                    case 0: // Sản phẩm cùng thương hiệu
                      products = relatedProducts.brand.rows;
                      break;
                    case 1: // Sản phẩm cùng danh mục
                      products = relatedProducts.category.rows;
                      break;
                    case 2: // Sản phẩm cùng nhà bán lẻ
                      products = relatedProducts.seller.rows;
                      break;
                    default:
                      products = [];
                  }

                  if (products.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.all(8.w),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.w,
                    crossAxisSpacing: 8.w,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return FinalProductCard(
                        product: product,
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: ProductBottomBar(),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: ProductDetailController.expandedHeight,
      collapsedHeight: ProductDetailController.collapsedHeight,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final expandedHeight = ProductDetailController.expandedHeight;
          final collapsedHeight = ProductDetailController.collapsedHeight;
          final currentHeight = constraints.maxHeight;
          final statusBarHeight = MediaQuery.of(context).padding.top;
          final minHeight = collapsedHeight + statusBarHeight;

          final progress = ((currentHeight - minHeight) / (expandedHeight - collapsedHeight)).clamp(0.0, 1.0);
          final isCollapsed = progress < 0.3;

          return Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: progress,
                child: const ProductImageCarousel(),
              ),
              if (isCollapsed)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: minHeight,
                    color: Colors.white,
                    padding: EdgeInsets.only(top: statusBarHeight),
                    child: _buildCollapsedHeader(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCollapsedHeader() {
    return Obx(() {
      final entity = controller.productDetailEntity.value;
      if (entity == null) {
        return const SizedBox.shrink();
      }

      return Row(
        children: [
          IconButton(
            onPressed: controller.goBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.w,
              color: AppColors.text500,
            ),
          ),
          Expanded(
            child: Text(
              entity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.heading5.copyWith(
                color: AppColors.text500,
              ),
            ),
          ),
          IconButton(
            onPressed: controller.shareProduct,
            icon: Icon(
              Symbols.share_rounded,
              size: 22.w,
              color: AppColors.text500,
            ),
          ),
          IconButton(
            onPressed: controller.goToCart,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Symbols.shopping_cart_rounded,
                  size: 22.w,
                  color: AppColors.text500,
                ),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

/// Reviews section
class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Đánh giá sản phẩm', style: AppTextStyles.heading5.copyWith(color: AppColors.text500)),
          SizedBox(height: 16.h),
          Center(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Icon(Symbols.rate_review_rounded, size: 64.w, color: AppColors.bg400),
                SizedBox(height: 16.h),
                Text('Chưa có đánh giá', style: AppTextStyles.heading6.copyWith(color: AppColors.text300)),
                SizedBox(height: 8.h),
                Text('Hãy là người đầu tiên đánh giá sản phẩm này', style: AppTextStyles.body14.copyWith(color: AppColors.text200), textAlign: TextAlign.center),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
