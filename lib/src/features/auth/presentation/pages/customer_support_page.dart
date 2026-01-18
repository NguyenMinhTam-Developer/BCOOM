import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/customer_support_controller.dart';

class CustomerSupportPage extends GetView<CustomerSupportController> {
  const CustomerSupportPage({super.key});

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
          'Hỗ trợ khách hàng',
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

        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 20.h,
                children: [
                  // Hotline Card (Work time section)
                  _buildHotlineCard(),
                  // FAQ List
                  if (controller.faqs.isEmpty)
                    Center(
                      child: Text(
                        'Không có câu hỏi nào',
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.text400,
                        ),
                      ),
                    )
                  else
                    _buildFaqList(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHotlineCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFE5E5), // Light pink background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.h,
        children: [
          // Header with phone icon and "Hotline" text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Symbols.phone,
                size: 20.w,
                color: Color(0xFFE0004D), // Magenta/pink color
              ),
              SizedBox(width: 8.w),
              Text(
                'Hotline',
                style: AppTextStyles.label14.copyWith(
                  color: Color(0xFFE0004D), // Magenta/pink color
                ),
              ),
            ],
          ),
          // Hotline number
          Text(
            '1900-6035',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.text500,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Call rate
          Text(
            'Cước phí 1000₫/ Phút',
            style: AppTextStyles.body12.copyWith(
              color: AppColors.text500,
            ),
          ),
          // Operating hours
          Text(
            'Thời gian từ 8h00 - 21h00, kể cả Thứ 7, Chủ Nhật',
            textAlign: TextAlign.center,
            style: AppTextStyles.body12.copyWith(
              color: AppColors.text500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    return Container(
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
          return _buildFaqItem(faq, context);
        },
      ),
    );
  }

  Widget _buildFaqItem(faq, BuildContext context) {
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
