import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/cart_controller.dart';

class CartSelectAllSection extends GetView<CartController> {
  const CartSelectAllSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartInfo = controller.cartInfo.value;
      if (cartInfo == null || cartInfo.products.isEmpty) {
        return const SizedBox.shrink();
      }

      final totalProducts = cartInfo.products.length;
      final isAllSelected = controller.isAllSelected();

      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: controller.toggleSelectAll,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isAllSelected ? AppColors.primaryColor : AppColors.ink6,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                  color: isAllSelected ? AppColors.primaryColor : Colors.transparent,
                ),
                child: isAllSelected
                    ? Icon(
                        Icons.check,
                        size: 14.w,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            SizedBox(width: 12.w),
            // Select all text
            Expanded(
              child: GestureDetector(
                onTap: controller.toggleSelectAll,
                child: Text(
                  'Chọn tất cả ($totalProducts)',
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.text500,
                  ),
                ),
              ),
            ),
            // Add to favorites
            TextButton.icon(
              onPressed: () {
                // TODO: Add all selected to favorites
                Get.snackbar('Thông báo', 'Đã thêm vào yêu thích');
              },
              icon: Icon(
                Symbols.favorite_border_rounded,
                size: 18.w,
                color: AppColors.text300,
              ),
              label: Text(
                'Thêm vào yêu thích',
                style: AppTextStyles.body12.copyWith(
                  color: AppColors.text300,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 8.w),
            // Delete all
            TextButton.icon(
              onPressed: controller.deleteAllSelected,
              icon: Icon(
                Symbols.delete_rounded,
                size: 18.w,
                color: AppColors.error500,
              ),
              label: Text(
                'Xoá tất cả',
                style: AppTextStyles.body12.copyWith(
                  color: AppColors.error500,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      );
    });
  }
}
