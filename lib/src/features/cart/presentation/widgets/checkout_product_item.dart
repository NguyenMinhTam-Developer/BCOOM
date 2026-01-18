import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';

class CheckoutProductItem extends StatelessWidget {
  final CartProductEntity product;

  const CheckoutProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    // Find selected variant
    CartProductVariantEntity? selectedVariant;
    if (product.variantId > 0 && product.variants.isNotEmpty) {
      try {
        selectedVariant = product.variants.firstWhere(
          (v) => v.id == product.variantId,
        );
      } catch (e) {
        // Variant not found, use first variant if available
        selectedVariant = product.variants.isNotEmpty ? product.variants.first : null;
      }
    }

    final variantName = selectedVariant != null ? selectedVariant.name : null;
    final displayPrice = selectedVariant?.priceSale ?? product.priceSale;
    final displayBasePrice = selectedVariant?.priceBase ?? product.priceBase;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.bg200,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported_rounded,
                    size: 20.w,
                    color: AppColors.text200,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Product info - Right column expanded
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name on top (max 2 lines)
                Text(
                  product.name,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.text500,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                // Variant below
                if (product.variants.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        'Phân loại: ',
                        style: AppTextStyles.body12.copyWith(
                          color: AppColors.text300,
                        ),
                      ),
                      Text(
                        variantName ?? product.variants.first.name,
                        style: AppTextStyles.body12.copyWith(
                          color: AppColors.text500,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 8.h),
                // Market price and sale price next (in a row)
                Row(
                  children: [
                    if (displayBasePrice != displayPrice) ...[
                      Text(
                        CurrencyUtils.formatVNDWithoutSymbol(displayBasePrice),
                        style: AppTextStyles.body12.copyWith(
                          color: AppColors.text200,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        ' ₫',
                        style: AppTextStyles.body10.copyWith(
                          color: AppColors.text200,
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      CurrencyUtils.formatVNDWithoutSymbol(displayPrice),
                      style: AppTextStyles.body14.copyWith(
                        color: AppColors.secondaryPink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '₫',
                      style: AppTextStyles.body10.copyWith(
                        color: AppColors.secondaryPink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Quantity as text
                Text(
                  'Số lượng: ${product.quantity}',
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.text300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
