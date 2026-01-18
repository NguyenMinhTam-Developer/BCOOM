import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

class CartPaymentMethodsSection extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onMethodSelected;

  const CartPaymentMethodsSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

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
          _PaymentMethodItem(
            label: 'Ví Gpay',
            value: 'gpay',
            isSelected: selectedMethod == 'gpay',
            onTap: () => onMethodSelected('gpay'),
          ),
          SizedBox(height: 12.h),
          _PaymentMethodItem(
            label: 'Chuyển khoản trước',
            value: 'bank_transfer',
            isSelected: selectedMethod == 'bank_transfer',
            note: 'Vào tài khoản ONE5',
            onTap: () => onMethodSelected('bank_transfer'),
          ),
          SizedBox(height: 12.h),
          _PaymentMethodItem(
            label: 'Tiền mặt (COD)',
            value: 'cod',
            isSelected: selectedMethod == 'cod',
            onTap: () => onMethodSelected('cod'),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final String? note;
  final VoidCallback onTap;

  const _PaymentMethodItem({
    required this.label,
    required this.value,
    required this.isSelected,
    this.note,
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
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primaryColor : AppColors.ink6,
                  width: 2,
                ),
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
            SizedBox(width: 12.w),
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
                  if (note != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      note!,
                      style: AppTextStyles.body12.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
