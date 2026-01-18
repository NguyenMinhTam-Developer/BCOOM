import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/routers/app_page_names.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterController extends GetxController {
  final RegisterWithEmailUseCase _registerUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final referralCodeController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isPasswordConfirmationVisible = false.obs;
  final RxBool isLoading = false.obs;
  final Rx<AuthData?> _authData = Rx<AuthData?>(null);

  RegisterController({
    required RegisterWithEmailUseCase registerUseCase,
  }) : _registerUseCase = registerUseCase;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordConfirmationVisibility() {
    isPasswordConfirmationVisible.value = !isPasswordConfirmationVisible.value;
  }

  Future<void> register() async {
    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;

    try {
      final authResponse = await _registerMethod();

      authResponse.fold(
        (failure) {
          switch (failure) {
            default:
              Get.snackbar('Đăng ký thất bại', failure.message, snackPosition: SnackPosition.TOP);
              break;
          }
        },
        (authResponse) async {
          _authData.value = authResponse.data;

          // Navigate to OTP verification page after successful registration
          Get.offAllNamed(AppPageNames.accountVerification);
        },
      );
    } catch (e) {
      Get.snackbar('Đăng ký thất bại', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Either<Failure, AuthResponse>> _registerMethod() async {
    var params = RegisterParams.create(
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: passwordConfirmationController.text.trim(),
    );

    return params.fold(
      (failure) => Left(failure),
      (validParams) => _registerUseCase(validParams),
    );
  }

  void navigateToLogin() {
    Get.offNamed(AppPageNames.login);
  }

  @override
  void onInit() {
    super.onInit();

    // Get referral code from arguments if provided
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map && arguments['referralCode'] != null) {
      referralCodeController.text = arguments['referralCode'] as String;
    }

    if (kDebugMode) {
      phoneController.text = '0338072985';
      emailController.text = 'nguyenminhtam.developer@gmail.com';
      fullNameController.text = 'Nguyen Minh Tam';
      passwordController.text = 'Bcoom!35';
      passwordConfirmationController.text = 'Bcoom!35';
    }
  }
}
