import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          height: 263.5.h,
          left: 0,
          right: 0,
          bottom: 0,
          child: Assets.svgs.splash.bottomBackground.svg(fit: BoxFit.fitWidth),
        ),
        Positioned(
          height: 161.34.h,
          left: 0,
          right: 0,
          bottom: 102.2.h,
          child: Assets.svgs.splash.bottomWave.svg(fit: BoxFit.fitWidth),
        ),
        Positioned(
          height: 244.h,
          top: 0,
          left: 0,
          right: 0,
          child: Assets.svgs.splash.topBackground.svg(fit: BoxFit.fitWidth),
        ),
        Positioned(
          height: 161.34.h,
          top: 0,
          left: 0,
          right: 0,
          child: Assets.svgs.splash.topWave.svg(fit: BoxFit.fitWidth),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Center(
      child: Assets.logos.logoSystemWhite.image(
        height: 60.h,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
