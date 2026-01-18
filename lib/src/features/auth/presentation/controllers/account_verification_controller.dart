import '../../../../core/routers/app_page_names.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/send_verification_notification_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

class AccountVerificationController extends GetxController {
  final SendVerificationNotificationUseCase _sendVerificationNotificationUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  final Rx<DateTime> expiresAt = DateTime.now().obs;

  AccountVerificationController(
    this._sendVerificationNotificationUseCase,
    this._verifyOtpUseCase,
  );

  final isLoading = false.obs;
  final otpController = TextEditingController();

  Future<void> sendVerificationNotification() async {
    try {
      isLoading.value = true;
      final result = await _sendVerificationNotificationUseCase(NoParams());
      result.fold(
        (failure) {
          Get.snackbar(
            'Lỗi',
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (dateTime) {
          expiresAt.value = dateTime;

          Get.snackbar(
            'Thành công',
            'Mã xác thực đã được gửi',
            snackPosition: SnackPosition.TOP,
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resendVerificationNotification() {
    sendVerificationNotification();
  }

  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      final result = await _verifyOtpUseCase(num.tryParse(otp));
      result.fold(
        (failure) {
          Get.snackbar(
            'Lỗi',
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (_) {
          Get.snackbar(
            'Thành công',
            'Xác thực thành công',
            snackPosition: SnackPosition.TOP,
          );

          Get.offAllNamed(AppPageNames.home);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    sendVerificationNotification();
  }
}
