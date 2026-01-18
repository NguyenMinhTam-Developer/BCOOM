import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => Visibility(
              visible: !controller.isLastPage.value,
              child: TextButton(
                onPressed: controller.skipOnboarding,
                child: Text('Bỏ qua'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              itemCount: controller.onboardingItems.length,
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Background image
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: AspectRatio(
                        aspectRatio: 310.52 / 356.45,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                            controller.onboardingItems[index].image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 48.h),
                    // This Size box is the indicator space,
                    SizedBox(height: 6.w),
                    SizedBox(height: 20.h),

                    // Content
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        spacing: 12.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            controller.onboardingItems[index].title,
                            style: AppTextStyles.heading2,
                          ),
                          Text(
                            controller.onboardingItems[index].description,
                            style: AppTextStyles.body14,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: AspectRatio(
                      aspectRatio: 310.52 / 356.45,
                      child: SizedBox(),
                    ),
                  ),
                  SizedBox(height: 48.h),
                  Row(
                    spacing: 6.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.onboardingItems.length,
                      (index) => Obx(
                        () => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: index == controller.currentPage.value ? 14.w : 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: controller.currentPage.value == index ? AppColors.primaryColor : AppColors.bg500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final label = controller.isLastPage.value ? 'Bắt đầu' : 'Tiếp tục';
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: AppButton.primary(
              label: label,
              onPressed: controller.isLastPage.value ? controller.completeOnboarding : controller.nextPage,
            ),
          ),
        );
      }),
    );
  }
}
