import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../controllers/product_detail_controller.dart';

/// Fixed bottom bar with action buttons
class ProductBottomBar extends GetView<ProductDetailController> {
  const ProductBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // Add to cart button
              _ActionIconButton(
                icon: Symbols.add_shopping_cart_rounded,
                label: 'Thêm vào giỏ hàng',
                onTap: controller.addToCart,
              ),

              SizedBox(width: 12.w),

              // Library/Gallery button
              _ActionIconButton(
                icon: Symbols.photo_library_rounded,
                label: 'Thư viện',
                onTap: controller.openGallery,
              ),

              SizedBox(width: 12.w),

              // Buy now button
              Expanded(
                child: GestureDetector(
                  onTap: controller.buyNow,
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryOrange,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Mua ngay',
                        style: AppTextStyles.label14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Action icon button for bottom bar
class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.bg200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 22.w,
              color: AppColors.secondary500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.cap8.copyWith(
              color: AppColors.text300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
