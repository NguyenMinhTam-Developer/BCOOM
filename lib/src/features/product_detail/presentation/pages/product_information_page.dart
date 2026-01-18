import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

/// Product Information Page
/// Shows detailed product information with HTML content
class ProductInformationPage extends StatelessWidget {
  const ProductInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final arguments = Get.arguments as Map<String, dynamic>?;
    final content = arguments?['content'] as String? ?? '';
    final title = arguments?['title'] as String? ?? 'Thông tin chi tiết';
    final productName = arguments?['productName'] as String? ?? '';

    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.w,
            color: AppColors.text500,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: AppColors.bg500,
        shape: const CircleBorder(),
        child: Icon(
          Icons.keyboard_arrow_up_rounded,
          color: AppColors.text500,
          size: 28.w,
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.all(16.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24.h,
            children: [
              // // Header - Product Name
              // if (productName.isNotEmpty)
              //   Text(
              //     productName,
              //     style: AppTextStyles.heading3.copyWith(color: AppColors.text500),
              //   ),

              // HTML Content
              if (content.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Html(
                    data: content,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      'p': Style(
                        margin: Margins.only(bottom: 12.h),
                        padding: HtmlPaddings.zero,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: FontSize(14.sp),
                        color: AppColors.text400,
                      ),
                      'h1': Style(
                        margin: Margins.only(bottom: 12.h),
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(20.sp),
                        color: AppColors.text500,
                      ),
                      'h2': Style(
                        margin: Margins.only(bottom: 12.h),
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(18.sp),
                        color: AppColors.text500,
                      ),
                      'h3': Style(
                        margin: Margins.only(bottom: 12.h),
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(16.sp),
                        color: AppColors.text500,
                      ),
                      'ul': Style(
                        margin: Margins.only(bottom: 12.h),
                        padding: HtmlPaddings.zero,
                      ),
                      'li': Style(
                        margin: Margins.only(bottom: 8.h),
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(14.sp),
                        color: AppColors.text400,
                      ),
                      'table': Style(
                        margin: Margins.only(bottom: 12.h),
                        padding: HtmlPaddings.zero,
                        border: Border.all(color: AppColors.bg400, width: 1),
                      ),
                      'th': Style(
                        padding: HtmlPaddings.all(8),
                        backgroundColor: AppColors.bg200,
                        border: Border.all(color: AppColors.bg400, width: 1),
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(14.sp),
                        color: AppColors.text500,
                      ),
                      'td': Style(
                        padding: HtmlPaddings.all(8),
                        border: Border.all(color: AppColors.bg400, width: 1),
                        fontSize: FontSize(14.sp),
                        color: AppColors.text400,
                      ),
                    },
                    extensions: [
                      TableHtmlExtension(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
