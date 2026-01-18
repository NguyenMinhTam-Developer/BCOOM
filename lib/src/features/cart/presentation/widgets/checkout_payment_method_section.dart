import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/cart_controller.dart';

class CheckoutPaymentMethodSection extends GetView<CartController> {
  const CheckoutPaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức thanh toán',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.text500,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children: [
                // First row - 3 items
                Row(
                  children: [
                    Expanded(
                      child: _PaymentMethodOption(
                        label: 'Thanh toán bằng tiền mặt (COD)',
                        value: 'cod',
                        icon: Icons.money,
                        iconColor: Colors.green,
                        isSelected: controller.selectedPaymentMethod.value == 'cod',
                        onTap: () => controller.selectedPaymentMethod.value = 'cod',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _PaymentMethodOption(
                        label: 'VISA Thẻ tín dụng/ Thẻ ghi nợ',
                        value: 'visa',
                        icon: Icons.credit_card,
                        iconColor: Colors.blue,
                        isSelected: controller.selectedPaymentMethod.value == 'visa',
                        onTap: () => controller.selectedPaymentMethod.value = 'visa',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _PaymentMethodOption(
                        label: 'Thẻ ATM',
                        value: 'atm',
                        icon: Icons.account_balance,
                        iconColor: Colors.blue,
                        isSelected: controller.selectedPaymentMethod.value == 'atm',
                        onTap: () => controller.selectedPaymentMethod.value = 'atm',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Second row - 2 items
                Row(
                  children: [
                    Expanded(
                      child: _PaymentMethodOption(
                        label: 'Ví Momo',
                        value: 'momo',
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.purple,
                        isSelected: controller.selectedPaymentMethod.value == 'momo',
                        onTap: () => controller.selectedPaymentMethod.value = 'momo',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _PaymentMethodOption(
                        label: 'Ví VNPay',
                        value: 'vnpay',
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.red,
                        isSelected: controller.selectedPaymentMethod.value == 'vnpay',
                        onTap: () => controller.selectedPaymentMethod.value = 'vnpay',
                      ),
                    ),
                    Expanded(child: SizedBox()), // Empty space for alignment
                  ],
                ),
              ],
            )),
        ],
      ),
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodOption({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
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
            color: isSelected ? AppColors.secondaryPink : AppColors.ink6,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.w,
              color: iconColor,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: AppTextStyles.body12.copyWith(
                color: AppColors.text500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
