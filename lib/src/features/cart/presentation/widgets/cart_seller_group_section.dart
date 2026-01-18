import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../controllers/cart_controller.dart';

class CartSellerGroupSection extends GetView<CartController> {
  final int sellerId;
  final String sellerName;
  final List<CartProductEntity> products;

  const CartSellerGroupSection({
    super.key,
    required this.sellerId,
    required this.sellerName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seller header with checkbox
          Obx(() {
            final isSellerSelected = controller.isSellerAllSelected(sellerId);
            return Row(
              children: [
                GestureDetector(
                  onTap: () => controller.toggleSellerSelection(sellerId),
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSellerSelected ? AppColors.primaryColor : AppColors.ink6,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: isSellerSelected ? AppColors.primaryColor : Colors.transparent,
                    ),
                    child: isSellerSelected
                        ? Icon(
                            Icons.check,
                            size: 14.w,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Symbols.store_rounded,
                  size: 18.w,
                  color: AppColors.text300,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    sellerName,
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.text500,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Show voucher dialog
                  },
                  icon: Icon(
                    Symbols.local_offer_rounded,
                    size: 16.w,
                    color: AppColors.secondaryPink,
                  ),
                  label: Text(
                    'Thêm mã giảm giá của shop',
                    style: AppTextStyles.body12.copyWith(
                      color: AppColors.secondaryPink,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                Icon(
                  Symbols.arrow_forward_ios_rounded,
                  size: 14.w,
                  color: AppColors.text300,
                ),
              ],
            );
          }),
          SizedBox(height: 16.h),

          // Product list
          ...products.map((product) => _ProductItem(product: product)),
        ],
      ),
    );
  }
}

class _ProductItem extends GetView<CartController> {
  final CartProductEntity product;

  const _ProductItem({required this.product});

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

    return Obx(() {
      final isSelected = controller.isProductSelected(product.id);

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
            // Checkbox - centered with image
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: GestureDetector(
                onTap: () => controller.toggleProductSelection(product.id),
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.primaryColor : AppColors.ink6,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 14.w,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(width: 12.w),
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
                      Symbols.image_not_supported_rounded,
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
                    GestureDetector(
                      onTap: () {
                        // TODO: Show variant selection dialog
                      },
                      child: Row(
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
                          SizedBox(width: 4.w),
                          Icon(
                            Symbols.arrow_drop_down_rounded,
                            size: 16.w,
                            color: AppColors.text300,
                          ),
                        ],
                      ),
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
                  SizedBox(height: 12.h),
                  // Increase/decrease input and trash icon in the same row
                  Row(
                    children: [
                      // Quantity selector
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (product.quantity > 1) {
                                controller.updateProductQuantity(product.id, product.quantity - 1);
                              }
                            },
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.ink6),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Icon(
                                Symbols.remove_rounded,
                                size: 16.w,
                                color: AppColors.text300,
                              ),
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 28.w,
                            alignment: Alignment.center,
                            child: Text(
                              '${product.quantity}',
                              style: AppTextStyles.body14.copyWith(
                                color: AppColors.text500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.updateProductQuantity(product.id, product.quantity + 1);
                            },
                            child: Container(
                              width: 28.w,
                              height: 28.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.ink6),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Icon(
                                Symbols.add_rounded,
                                size: 16.w,
                                color: AppColors.text300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      // Trash can icon for remove
                      GestureDetector(
                        onTap: () => controller.deleteProduct(product.id),
                        child: Icon(
                          Symbols.delete_rounded,
                          size: 20.w,
                          color: AppColors.text300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

