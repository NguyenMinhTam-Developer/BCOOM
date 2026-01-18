import '../../../../core/routers/app_page_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../domain/usecases/forgot_password_usecase.dart';

class ForgotPasswordController extends GetxController {
  final SendResetPasswordRequestByEmailUseCase _sendResetPasswordRequestByEmailUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;
  final emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  ForgotPasswordController(this._sendResetPasswordRequestByEmailUseCase);

  Future<void> sendResetPasswordRequest() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;
    try {
      final result = await _sendResetPasswordRequestByEmailUseCase(
        SendResetPasswordRequestByEmailParams(email: emailController.text.trim()),
      );
      result.fold(
        (failure) {
          Get.snackbar('Thất bại', failure.message, snackPosition: SnackPosition.TOP);
        },
        (token) {
          AppPageNames.navigateToGenericOtpVerification(
            email: emailController.text.trim(),
            token: token,
            onSuccess: (otp) {
              AppPageNames.navigateToResetPassword(
                otp: otp,
                token: token,
                onSuccess: () {
                  // Handle successful password reset
                  Get.offAllNamed(AppPageNames.login);

                  Get.snackbar('Thành công', 'Mật khẩu đã được đặt lại', snackPosition: SnackPosition.TOP);
                },
                onFailure: (error) {
                  // Handle password reset failure
                  Get.snackbar('Thất bại', error, snackPosition: SnackPosition.TOP);
                },
              );
            },
            onFailure: (error) {
              Get.snackbar('Thất bại', error, snackPosition: SnackPosition.TOP);
            },
          );
        },
      );
    } catch (e) {
      Get.snackbar('Thất bại', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
