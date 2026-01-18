import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

class GenericOtpVerificationController extends GetxController {
  final String email;
  final String token;
  final void Function(String otp)? onSuccess;
  final void Function(String error)? onFailure;

  final isLoading = false.obs;
  final otpController = TextEditingController();

  final SendResetPasswordRequestByEmailUseCase _sendResetPasswordRequestByEmailUseCase = Get.find<SendResetPasswordRequestByEmailUseCase>();

  GenericOtpVerificationController({
    required this.email,
    required this.token,
    this.onSuccess,
    this.onFailure,
  });

  Future<void> resendVerificationNotification() async {
    try {
      isLoading.value = true;
      final result = await _sendResetPasswordRequestByEmailUseCase(
        SendResetPasswordRequestByEmailParams(email: email),
      );
      result.fold(
        (failure) {
          Get.snackbar('Lỗi', failure.message, snackPosition: SnackPosition.TOP);
          if (onFailure != null) onFailure!(failure.message);
        },
        (_) {
          Get.snackbar('Thành công', 'Mã xác thực đã được gửi', snackPosition: SnackPosition.TOP);
        },
      );
    } catch (e) {
      Get.snackbar('Lỗi', e.toString(), snackPosition: SnackPosition.TOP);
      if (onFailure != null) onFailure!(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      // Implement your OTP verification logic here, e.g. call a remote data source or usecase
      // For now, just simulate success
      if (otp.length == 6) {
        Get.snackbar('Thành công', 'Xác thực thành công', snackPosition: SnackPosition.TOP);
        if (onSuccess != null) onSuccess!(otp);
      } else {
        throw Exception('OTP không hợp lệ');
      }
    } catch (e) {
      Get.snackbar('Lỗi', e.toString(), snackPosition: SnackPosition.TOP);
      if (onFailure != null) onFailure!(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
