import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          appBar: AppBar(),
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
                    'Nhập mã OTP',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text500,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.text400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Vui lòng nhập mã xác thực được gửi đến email ',
                                ),
                                TextSpan(
                                  text: _getPartialEmail(controller.email),
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                // TextSpan(
                                //   text: ' của bạn.',
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),
                          _buildPinPut(),
                          SizedBox(height: 24.h),
                          Obx(
                            () => FilledButton(
                              onPressed: controller.isLoading.value ? null : () => controller.verifyOtp(controller.otpController.text),
                              child: Text('Xác thực'),
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
      width: 40.w,
      height: 40.h,
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

String _getPartialEmail(String email) {
  if (!email.contains('@')) {
    return email;
  }
  final parts = email.split('@');
  final local = parts[0];
  final domain = parts[1];
  if (local.length > 3) {
    return '${local.substring(0, 3)}...@$domain';
  }
  return email;
}
