import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.isSelected,
    required this.name,
    required this.onTap,
  });

  final bool isSelected;
  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isSelected)
          Positioned(
            left: 0,
            height: 24.h,
            width: 4.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary500,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
            child: Column(
              spacing: 4.h,
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary100 : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Assets.logos.appIcon.image(fit: BoxFit.cover),
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: (isSelected ? AppTextStyles.label10 : AppTextStyles.body10).copyWith(
                    color: isSelected ? AppColors.primary500 : AppColors.text300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
