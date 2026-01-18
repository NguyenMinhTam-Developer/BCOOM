import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../domain/usecases/reset_password_usecase.dart';

class ResetPasswordController extends GetxController {
  final String otp;
  final String token;
  final void Function()? onSuccess;
  final void Function(String error)? onFailure;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isPasswordConfirmationVisible = false.obs;

  final ResetPasswordUseCase _resetPasswordUseCase = Get.find<ResetPasswordUseCase>();

  ResetPasswordController({
    required this.otp,
    required this.token,
    this.onSuccess,
    this.onFailure,
  });

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordConfirmationVisibility() {
    isPasswordConfirmationVisible.value = !isPasswordConfirmationVisible.value;
  }

  Future<void> resetPassword() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;

    try {
      final result = await _resetPasswordUseCase(
        ResetPasswordParams(
          otp: otp,
          token: token,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
        ),
      );

      result.fold(
        (failure) {
          Get.snackbar('Thất bại', failure.message, snackPosition: SnackPosition.TOP);
          if (onFailure != null) onFailure!(failure.message);
        },
        (_) {
          Get.snackbar('Thành công', 'Mật khẩu đã được đặt lại thành công', snackPosition: SnackPosition.TOP);
          if (onSuccess != null) onSuccess!();
        },
      );
    } catch (e) {
      Get.snackbar('Thất bại', e.toString(), snackPosition: SnackPosition.TOP);
      if (onFailure != null) onFailure!(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
