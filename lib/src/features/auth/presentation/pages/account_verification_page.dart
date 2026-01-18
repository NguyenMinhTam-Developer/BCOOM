import 'dart:async';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/routers/app_page_names.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/services/session/session_service.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/account_verification_controller.dart';

class AccountVerificationPage extends StatefulWidget {
  const AccountVerificationPage({super.key});

  @override
  State<AccountVerificationPage> createState() => _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  final controller = Get.find<AccountVerificationController>();
  Timer? _timer;
  final Rx<DateTime> _currentTime = DateTime.now().obs;

  @override
  void initState() {
    super.initState();
    _currentTime.value = DateTime.now();
    _startTimer();
    // Restart timer when expiresAt changes (e.g., when resending code)
    ever(controller.expiresAt, (_) {
      _restartTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _restartTimer() {
    _timer?.cancel();
    _currentTime.value = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _currentTime.value = DateTime.now();
      final remaining = controller.expiresAt.value.difference(_currentTime.value);
      if (remaining.isNegative || remaining.inSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    spacing: 4.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Nhập mã OTP',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading2.copyWith(color: AppColors.text500),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                          children: [
                            TextSpan(
                              text: 'Vui lòng nhập mã xác thực được gửi đến email ',
                            ),
                            TextSpan(
                              text: SessionService.instance.currentUser.value?.partialEmail ?? '',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: ' của bạn.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        spacing: 20.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            spacing: 12.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Obx(
                                () {
                                  // Explicitly observe both observables to ensure updates
                                  final expiresAt = controller.expiresAt.value;
                                  final currentTime = _currentTime.value;
                                  final remaining = expiresAt.difference(currentTime);
                                  final minutes = remaining.inMinutes;
                                  final seconds = remaining.inSeconds % 60;
                                  final isExpired = remaining.isNegative || remaining.inSeconds <= 0;

                                  return RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                                      children: isExpired
                                          ? [
                                              TextSpan(text: "Mã xác thực đã hết hiệu lực, vui lòng gửi lại"),
                                            ]
                                          : [
                                              TextSpan(text: "Mã xác thực có hiệu lực trong "),
                                              TextSpan(
                                                text: minutes > 0 ? "$minutes:$seconds" : "$seconds",
                                                style: TextStyle(color: AppColors.error500),
                                              ),
                                            ],
                                    ),
                                  );
                                },
                              ),
                              _buildPinPut(),
                            ],
                          ),
                          Obx(
                            () => FilledButton(
                              onPressed: controller.isLoading.value ? null : () => controller.verifyOtp(controller.otpController.text),
                              child: Text('Xác thực'),
                            ),
                          ),
                          Align(
                            child: Obx(
                              () => AppButton.ghost(
                                size: ButtonSize.small,
                                onPressed: controller.isLoading.value ? null : controller.resendVerificationNotification,
                                label: 'Gửi lại mã',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Obx(
                      () => AppButton.outline(
                        label: 'Đăng xuất',
                        size: ButtonSize.large,
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                await SessionService.instance.clearSession();
                                Get.offAllNamed(AppPageNames.home);
                              },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 40.w,
      height: 40.w,
      textStyle: AppTextStyles.heading4.copyWith(
        color: AppColors.text500,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.bg500),
      ),
    );

    final focusedPinTheme = PinTheme(
      width: 40.w,
      height: 40.w,
      textStyle: AppTextStyles.heading4.copyWith(
        color: AppColors.text500,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text300),
      ),
    );

    final errorPinTheme = PinTheme(
      width: 40.w,
      height: 40.w,
      textStyle: AppTextStyles.heading4.copyWith(
        color: AppColors.text500,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.error500),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller.otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      errorPinTheme: errorPinTheme,
      onCompleted: (pin) => controller.verifyOtp(pin),
    );
  }
}
