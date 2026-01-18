import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.rawTitle,
    required this.content,
    this.ctaTitle,
    this.padding,
  });

  final String rawTitle;
  final String content;
  final String? ctaTitle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final totalLength = rawTitle.toString().split('<br>').length;

    final title = rawTitle.toString().split('<br>').lastOrNull ?? '';
    final subtitle = rawTitle.toString().split('<br>').firstOrNull ?? '';

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.w,
              children: [
                Container(
                  width: 7.h,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryPink,
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalLength > 1 ? subtitle : '',
                      style: GoogleFonts.inter(
                        color: AppColors.secondaryPink,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.ibmPlexSerif(
                        color: AppColors.ink1,
                        fontWeight: FontWeight.w400,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Divider(
                        color: AppColors.red8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (content.isNotEmpty)
            Html(
              data: content,
              style: {
                'body': Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                'p': Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: FontSize(14.sp),
                ),
              },
            ),
          if (ctaTitle != null)
            AppButton.primary(
              label: ctaTitle!,
              size: ButtonSize.small,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
