import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/product_detail_controller.dart';

/// Image carousel widget for product detail page
/// Displays swipeable product images with page indicators
class ProductImageCarousel extends GetView<ProductDetailController> {
  const ProductImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entity = controller.productDetailEntity.value;
      if (entity == null) {
        return Container(
          color: AppColors.bg200,
        );
      }

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

      return Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onImagePageChanged,
            itemCount: uniqueImages.length,
            itemBuilder: (context, index) {
              final imageUrl = uniqueImages[index];

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.bg300,
                      AppColors.bg200,
                    ],
                  ),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to placeholder on error
                    return Assets.images.products.productDetailImage.image(
                      fit: BoxFit.cover,
                    );
                  },
                ),
              );
            },
          ),

          // Top action buttons
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                _ActionButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: controller.goBack,
                ),
                Row(
                  spacing: 8.w,
                  children: [
                    // Share button
                    _ActionButton(
                      icon: Symbols.share_rounded,
                      onTap: controller.shareProduct,
                    ),
                    // Cart button
                    _ActionButton(
                      icon: Symbols.shopping_cart_rounded,
                      onTap: controller.goToCart,
                      hasBadge: true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Page indicator (bottom-right)
          Positioned(
            bottom: 16.h,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Obx(() => Text(
                    '${controller.currentImageIndex.value + 1}/${uniqueImages.length}',
                    style: AppTextStyles.body12.copyWith(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ],
      );
    });
  }
}

/// Action button widget for carousel overlay
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool hasBadge;

  const _ActionButton({
    required this.icon,
    required this.onTap,
    this.hasBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              size: 18.w,
              color: AppColors.text500,
            ),
            if (hasBadge)
              Positioned(
                top: 6.h,
                right: 6.w,
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
    );
  }
}
