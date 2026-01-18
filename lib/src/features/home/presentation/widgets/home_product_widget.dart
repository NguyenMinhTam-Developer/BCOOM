import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

class HomeProductWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeProductWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4.h,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Assets.images.products.productThumbnail.image(fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.sematicRed,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text("Hot", style: AppTextStyles.cap8.copyWith(color: Colors.white)),
                      ),
                    ),
                    Positioned(
                      top: 4.h,
                      right: 4.h,
                      child: Icon(
                        Symbols.favorite_rounded,
                        color: Colors.white,
                        size: 20.w,
                        fill: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h).copyWith(top: 0),
              child: Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Balo gấu học sinh cấp 1 chống gù lưng\n",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.label12.copyWith(color: AppColors.text500),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Từ: ", style: AppTextStyles.cap10.copyWith(color: AppColors.primary500)),
                              TextSpan(text: "100.000 VNĐ", style: AppTextStyles.label12.copyWith(color: AppColors.primary500)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.r),
                            topRight: Radius.circular(8.r),
                            bottomLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),
                          side: BorderSide(color: AppColors.primary500, width: 1.w),
                        ),
                        child: SizedBox(
                          width: 20.h,
                          height: 20.h,
                          child: Icon(
                            Symbols.add_rounded,
                            color: AppColors.secondary600,
                            weight: 900,
                            size: 12.h,
                          ),
                        ),
                      ),
                    ],
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
