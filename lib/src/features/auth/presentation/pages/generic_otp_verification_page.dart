import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/generic_otp_verification_controller.dart';

class GenericOtpVerificationPage extends GetView<GenericOtpVerificationController> {
  const GenericOtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Hero(
                  //     tag: 'logo',
                  //     child: Assets.svgs.pharmacomSplashLogo.image(
                  //       width: 172.w,
                  //       height: 92.h,
                  //     ),
                  //   ),
                  // ),
                  Text(
                    'Xác thực OTP',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildPinPut(),
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Mã xác thực đã gửi đến Zalo có số  ',
                                ),
                                TextSpan(
                                  text: controller.email,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: ', vui lòng kiểm tra để lấy mã xác thực tài khoản.',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Align(
                            child: Obx(
                              () => FilledButton(
                                onPressed: controller.isLoading.value ? null : () => controller.verifyOtp(controller.otpController.text),
                                child: Text('Xác thực'),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            "Không nhận được mã xác thực?",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            child: Obx(
                              () => TextButton(
                                onPressed: controller.isLoading.value ? null : controller.resendVerificationNotification,
                                child: Text(
                                  'Gửi lại',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF00C800),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 80.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller.otpController,
      defaultPinTheme: defaultPinTheme,
      onCompleted: (pin) => controller.verifyOtp(pin),
    );
  }
}
