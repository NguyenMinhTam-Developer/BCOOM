import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/page_view_controller.dart';

class PageViewPage extends GetView<PageViewController> {
  const PageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Symbols.arrow_back,
            color: AppColors.text500,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final pageTitle = controller.page.value?.title ?? '';
          return Text(
            pageTitle,
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.text500,
            ),
          );
        }),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        final pageData = controller.page.value;
        if (pageData == null) {
          return Center(
            child: Text(
              'Không tìm thấy nội dung',
              style: AppTextStyles.body14.copyWith(
                color: AppColors.text400,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (pageData.content.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 8.r,
                          spreadRadius: 0,
                          color: Colors.black.withValues(alpha: 0.05),
                        ),
                      ],
                    ),
                    child: Html(
                      data: pageData.content,
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
        );
      }),
    );
  }
}
