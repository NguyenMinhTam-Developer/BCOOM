import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../search/domain/entities/search_product_entity.dart';

class CatalogProductWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final SearchProductEntity? product;

  const CatalogProductWidget({
    super.key,
    this.onTap,
    this.product,
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
            topRight: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
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
                        size: 16.w,
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
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Tồn kho: ", style: AppTextStyles.cap10.copyWith(color: AppColors.text200)),
                        TextSpan(text: "1000", style: AppTextStyles.cap10.copyWith(color: AppColors.info500)),
                      ],
                    ),
                  ),
                  Text(
                    product?.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cap10.copyWith(color: AppColors.text500),
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
                              TextSpan(text: "100.000 VNĐ", style: AppTextStyles.cap10.copyWith(color: AppColors.primary500)),
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
                          width: 20.w,
                          height: 20.w,
                          child: Icon(
                            Symbols.add_rounded,
                            color: AppColors.secondary600,
                            weight: 900,
                            size: 12.w,
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
