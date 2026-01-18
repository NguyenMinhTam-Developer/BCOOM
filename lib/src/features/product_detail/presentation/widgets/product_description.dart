import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/product_detail_controller.dart';

/// Product description section with expandable content
class ProductDescription extends GetView<ProductDetailController> {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entity = controller.productDetailEntity.value;
      if (entity == null || entity.description == null || entity.description!.isEmpty) {
        return const SizedBox.shrink();
      }

      final content = entity.description!;

      return Column(
        spacing: 20.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HTML Content with fade effect
          _buildHtmlContentWithFade(content),

          // See more button
          Center(
            child: GestureDetector(
              onTap: () => controller.navigateToProductInfo(
                content: content,
                title: 'Chi tiết sản phẩm',
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.bg400),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xem thêm',
                      style: AppTextStyles.label12.copyWith(
                        color: AppColors.text400,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Symbols.arrow_forward_rounded,
                      size: 16.w,
                      color: AppColors.text400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHtmlContentWithFade(String htmlContent) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100.h,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // HTML content
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Html(
                  data: htmlContent,
                  style: {
                    "body": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      fontSize: FontSize(14.sp),
                      color: AppColors.text400,
                    ),
                    "p": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "div": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "h1, h2, h3, h4, h5, h6": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "ul, ol": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "li": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "table": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      border: Border.all(color: AppColors.bg400, width: 1),
                    ),
                    "th": Style(
                      padding: HtmlPaddings.all(8),
                      backgroundColor: AppColors.bg200,
                      border: Border.all(color: AppColors.bg400, width: 1),
                      fontWeight: FontWeight.bold,
                    ),
                    "td": Style(
                      padding: HtmlPaddings.all(8),
                      border: Border.all(color: AppColors.bg400, width: 1),
                    ),
                  },
                  extensions: [
                    TableHtmlExtension(),
                  ],
                ),
              ),

              // Fade effect at bottom (only show if content might overflow)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
