import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';

class CartOnePointSection extends StatelessWidget {
  final int availablePoints;
  final ValueChanged<bool> onToggle;
  final int pointsUsed;

  const CartOnePointSection({
    super.key,
    required this.availablePoints,
    required this.onToggle,
    required this.pointsUsed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = pointsUsed > 0;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bạn đang có ${CurrencyUtils.formatVNDWithoutSymbol(availablePoints)} ONE Point',
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.text500,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isEnabled,
                onChanged: onToggle,
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
          if (isEnabled) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    'Đã dùng ',
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.text500,
                    ),
                  ),
                  Text(
                    '${CurrencyUtils.formatVNDWithoutSymbol(pointsUsed)} Point',
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
