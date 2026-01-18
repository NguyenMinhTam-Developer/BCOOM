import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

class CartEinvoiceSection extends StatelessWidget {
  const CartEinvoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Symbols.receipt_long_rounded,
                size: 20.w,
                color: AppColors.text500,
              ),
              SizedBox(width: 8.w),
              Text(
                'Hóa đơn điện tử',
                style: AppTextStyles.heading5.copyWith(
                  color: AppColors.text500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.info100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Symbols.info_rounded,
                  size: 16.w,
                  color: AppColors.info500,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Lưu ý: ONE5 chỉ xuất hóa đơn điện tử',
                    style: AppTextStyles.body12.copyWith(
                      color: AppColors.info500,
                    ),
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
