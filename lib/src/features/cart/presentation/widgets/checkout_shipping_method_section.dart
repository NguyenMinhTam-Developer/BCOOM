import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/cart_controller.dart';

class CheckoutShippingMethodSection extends GetView<CartController> {
  const CheckoutShippingMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hình thức giao hàng',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.text500,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: _ShippingMethodOption(
                      label: 'Giao hàng tiết kiệm',
                      price: 16000,
                      value: 'economy',
                      isSelected: controller.selectedShippingMethod.value == 'economy',
                      onTap: () => controller.selectedShippingMethod.value = 'economy',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ShippingMethodOption(
                      label: 'Giao hàng siêu tốc trong 2H',
                      price: 28000,
                      value: 'express',
                      isSelected: controller.selectedShippingMethod.value == 'express',
                      onTap: () => controller.selectedShippingMethod.value = 'express',
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _ShippingMethodOption extends StatelessWidget {
  final String label;
  final int price;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const _ShippingMethodOption({
    required this.label,
    required this.price,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.ink6,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.text500,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '(${CurrencyUtils.formatVNDWithoutSymbol(price)}₫)',
                    style: AppTextStyles.body12.copyWith(
                      color: AppColors.text300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
