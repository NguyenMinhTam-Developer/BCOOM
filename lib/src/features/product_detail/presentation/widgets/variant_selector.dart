import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/product_variant_entity.dart';
import '../controllers/product_detail_controller.dart';

/// Color selector widget with horizontal scrollable swatches
class ProductVariantSelector extends GetView<ProductDetailController> {
  const ProductVariantSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Access reactive variables inside Obx
      final selectedProductId = controller.selectedProductId.value;
      final variants = controller.productDetailEntity.value?.variants ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          // Title with count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Phân loại',
              style: AppTextStyles.label12.copyWith(
                color: AppColors.text500,
              ),
            ),
          ),
          // Variant chips
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: variants.map((variant) {
                final isSelected = selectedProductId == variant.id;
                return _VariantChip(
                  variant: variant,
                  isSelected: isSelected,
                  onTap: () => controller.toggleVariantSelection(variant.id),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}

/// Individual variant chip widget with selection animation
class _VariantChip extends StatelessWidget {
  final ProductVariantEntity variant;
  final bool isSelected;
  final VoidCallback onTap;

  const _VariantChip({
    required this.variant,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        // width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.secondaryPink : AppColors.ink6,
            width: isSelected ? 1.w : 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4.w,
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Image.network(
                variant.imageUrl + variant.imageLocation,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported_outlined,
                    size: 16.w,
                    color: AppColors.text200,
                  );
                },
              ),
            ),
            Text(
              variant.name,
              style: AppTextStyles.body14.copyWith(
                color: AppColors.ink1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
