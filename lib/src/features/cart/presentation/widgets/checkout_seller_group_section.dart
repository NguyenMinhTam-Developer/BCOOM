import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';
import 'checkout_product_item.dart';

class CheckoutSellerGroupSection extends StatelessWidget {
  final int sellerId;
  final String sellerName;
  final List<CartProductEntity> products;

  const CheckoutSellerGroupSection({
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
          // Seller header
          Row(
            children: [
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
            ],
          ),
          SizedBox(height: 16.h),

          // Product list
          ...products.map((product) => CheckoutProductItem(product: product)),
        ],
      ),
    );
  }
}
