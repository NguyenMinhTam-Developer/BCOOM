import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';

class CartOrderSummarySection extends StatelessWidget {
  final num totalProducts;
  final int pointsUsed;
  final num shippingFee;
  final num total;
  final num discount;
  final int selectedCount;

  const CartOrderSummarySection({
    super.key,
    required this.totalProducts,
    required this.pointsUsed,
    required this.shippingFee,
    required this.total,
    required this.discount,
    this.selectedCount = 0,
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
            'Tổng đơn hàng',
            style: AppTextStyles.heading5.copyWith(
              color: AppColors.text500,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sản phẩm đã chọn',
                style: AppTextStyles.body14.copyWith(
                  color: AppColors.text300,
                ),
              ),
              Text(
                '$selectedCount',
                style: AppTextStyles.body14.copyWith(
                  color: AppColors.text500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _SummaryRow(
            label: 'Tổng tiền',
            value: totalProducts,
          ),
          SizedBox(height: 8.h),
          _SummaryRow(
            label: 'Phí vận chuyển',
            value: shippingFee,
          ),
          SizedBox(height: 8.h),
          _SummaryRow(
            label: 'Ưu đãi từ BCOOM',
            value: -discount,
            valueColor: AppColors.primaryColor,
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.ink6),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thanh toán',
                style: AppTextStyles.heading5.copyWith(
                  color: AppColors.text500,
                ),
              ),
              Row(
                children: [
                  Text(
                    CurrencyUtils.formatVNDWithoutSymbol(total),
                    style: AppTextStyles.heading4.copyWith(
                      color: AppColors.secondaryPink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'đ',
                    style: AppTextStyles.body10.copyWith(
                      color: AppColors.secondaryPink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final num value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value < 0 ? -value : value;
    final prefix = value < 0 ? '-' : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body14.copyWith(
            color: AppColors.text300,
          ),
        ),
        Row(
          children: [
            if (prefix.isNotEmpty)
              Text(
                prefix,
                style: AppTextStyles.body14.copyWith(
                  color: valueColor ?? AppColors.text500,
                ),
              ),
            Text(
              CurrencyUtils.formatVNDWithoutSymbol(displayValue),
              style: AppTextStyles.body14.copyWith(
                color: valueColor ?? AppColors.text500,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              'đ',
              style: AppTextStyles.body10.copyWith(
                color: valueColor ?? AppColors.text500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
