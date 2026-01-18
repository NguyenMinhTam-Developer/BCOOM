import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/faq_detail_controller.dart';

class FaqDetailPage extends GetView<FaqDetailController> {
  const FaqDetailPage({super.key});

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
        title: Text(
          controller.category.name,
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.text500,
          ),
        ),
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

        if (controller.faqs.isEmpty) {
          return Center(
            child: Text(
              'Không có câu hỏi nào',
              style: AppTextStyles.body14.copyWith(
                color: AppColors.text400,
              ),
            ),
          );
        }

        return SizedBox(
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.all(16.w),
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
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.faqs.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.bg400,
                ),
                itemBuilder: (context, index) {
                  final faq = controller.faqs[index];
                  return _buildFaqItem(faq, index, context);
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFaqItem(faq, int index, BuildContext context) {
    return Obx(() {
      final isExpanded = controller.isExpanded(faq.id);

      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey('faq_${faq.id}_${isExpanded}'),
          title: Text(
            faq.question,
            style: AppTextStyles.label14.copyWith(
              color: AppColors.text500,
            ),
          ),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          iconColor: AppColors.text400,
          collapsedIconColor: AppColors.text400,
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          collapsedShape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) {
            if (expanded) {
              controller.setExpandedItem(faq.id);
            } else {
              controller.setExpandedItem(null);
            }
          },
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                faq.answer,
                style: AppTextStyles.body14.copyWith(
                  color: AppColors.text400,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
