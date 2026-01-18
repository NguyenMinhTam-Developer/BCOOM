import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/routers/app_page_names.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OnboardingItem> get onboardingItems => [
        OnboardingItem(
          title: 'Kinh doanh không vốn',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: Assets.svgs.onboarding.onboardingBg1.path,
        ),
        OnboardingItem(
          title: 'Đào tạo bài bản',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: Assets.svgs.onboarding.onboardingBg2.path,
        ),
        OnboardingItem(
          title: 'Thu nhập thụ động',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          image: Assets.svgs.onboarding.onboardingBg3.path,
        ),
      ];
}

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;
  final RxList<OnboardingItem> onboardingItems = OnboardingItem.onboardingItems.obs;
  final RxBool isLastPage = false.obs;
  final PageController pageController = PageController();

  void nextPage() {
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPageChanged(int value) {
    currentPage.value = value;
    isLastPage.value = currentPage.value == onboardingItems.length - 1;
  }

  void skipOnboarding() {
    Get.offAllNamed(AppPageNames.home);
  }

  void completeOnboarding() {
    Get.offAllNamed(AppPageNames.home);
  }
}
