import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/sales_controller.dart';

class SalesPage extends GetView<SalesController> {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  spacing: 20.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Doanh số",
                      style: AppTextStyles.heading2.copyWith(color: AppColors.text500),
                    ),
                    Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          "Thống kê doanh số",
                          style: AppTextStyles.heading4.copyWith(color: AppColors.text400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
