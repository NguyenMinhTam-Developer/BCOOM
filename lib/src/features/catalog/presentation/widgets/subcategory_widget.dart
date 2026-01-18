import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    super.key,
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: AppColors.pink8, width: 1.w),
          // borderRadius: BorderRadius.circular(12.r),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 4),
          //     blurRadius: 16.r,
          //     spreadRadius: 0,
          //     color: Colors.black.withValues(alpha: 0.1),
          //   ),
          // ],
        ),
        child: Column(
          spacing: 4.h,
          children: [
            Container(
              width: 46.w,
              height: 46.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Assets.logos.appIcon.image(fit: BoxFit.cover),
            ),
            Text(
              "$name\n",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppTextStyles.body10.copyWith(
                color: AppColors.text300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
