import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/value_objects/change_password_params.dart';

class ChangePasswordController extends GetxController {
  final ChangePassword _changePassword;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isOldPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  ChangePasswordController({
    required ChangePassword changePassword,
  }) : _changePassword = changePassword;

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> changePassword() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;

    try {
      final params = ChangePasswordParams.create(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      final result = await params.fold(
        (failure) async => Left(failure),
        (validParams) async => await _changePassword(validParams),
      );

      result.fold(
        (failure) {
          Get.snackbar('Lỗi đổi mật khẩu', failure.message, snackPosition: SnackPosition.TOP);
        },
        (_) {
          Get.back();
          Get.snackbar(
            'Thành công',
            'Mật khẩu đã được thay đổi thành công',
            snackPosition: SnackPosition.TOP,
          );
        },
      );
    } catch (e) {
      Get.snackbar('Lỗi đổi mật khẩu', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
