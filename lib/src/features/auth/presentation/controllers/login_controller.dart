import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/routers/app_page_names.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_with_bcoomid.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/login_with_phone.dart';

enum LoginMethod {
  phone,
  email,
  idBcoom,
}

class LoginController extends GetxController {
  final LoginWithEmail _loginWithEmail;
  final LoginWithPhone _loginWithPhone;
  final LoginWithIdBcoom _loginWithIdBcoom;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final idBcoomController = TextEditingController();

  final Rx<LoginMethod> selectedLoginMethod = LoginMethod.phone.obs;

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final Rx<UserEntity?> user = Rx<UserEntity?>(null);

  LoginController({
    required LoginWithEmail loginWithEmail,
    required LoginWithPhone loginWithPhone,
    required LoginWithIdBcoom loginWithIdBcoom,
  })  : _loginWithEmail = loginWithEmail,
        _loginWithPhone = loginWithPhone,
        _loginWithIdBcoom = loginWithIdBcoom;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;

    try {
      Either<Failure, AuthResponse> authResponse;

      switch (selectedLoginMethod.value) {
        case LoginMethod.email:
          authResponse = await _loginWithEmailMethod();
          break;
        case LoginMethod.phone:
          authResponse = await _loginWithPhoneMethod();
          break;
        case LoginMethod.idBcoom:
          authResponse = await _loginWithIdBcoomMethod();
          break;
      }

      authResponse.fold(
        (failure) {
          print(failure.runtimeType);
          switch (failure) {
            case EmailNotVerifiedFailure():
              Get.toNamed(AppPageNames.accountVerification, arguments: failure.authResponse);
              break;
            default:
              Get.snackbar('Đăng nhập thất bại', failure.message, snackPosition: SnackPosition.TOP);
              break;
          }
        },
        (authResponse) async {
          user.value = authResponse.data.user;

          if (user.value?.emailVerifiedAt == null) {
            Get.toNamed(AppPageNames.accountVerification);
          } else {
            AppPageNames.navigateToHome();

            Get.snackbar(
              "Thông báo",
              authResponse.description,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
      );
    } catch (e) {
      Get.snackbar('Đăng nhập thất bại', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Either<Failure, AuthResponse>> _loginWithEmailMethod() async {
    final params = LoginWithEmailParams.create(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    return params.fold(
      (failure) => Left(failure),
      (validParams) => _loginWithEmail(validParams),
    );
  }

  Future<Either<Failure, AuthResponse>> _loginWithPhoneMethod() async {
    final params = LoginWithPhoneParams.create(
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text,
    );

    return params.fold(
      (failure) => Left(failure),
      (validParams) => _loginWithPhone(validParams),
    );
  }

  Future<Either<Failure, AuthResponse>> _loginWithIdBcoomMethod() async {
    final params = LoginWithIdBcoomParams.create(
      bcoomId: idBcoomController.text.trim(),
      password: passwordController.text,
    );

    return params.fold(
      (failure) => Left(failure),
      (validParams) => _loginWithIdBcoom(validParams),
    );
  }

  void navigateToRegister() {
    Get.offNamed(AppPageNames.roleSelection);
  }

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      emailController.text = 'nguyenminhtam.developer@gmail.com';
      phoneController.text = '0338072985';
      idBcoomController.text = '1234567890';
      passwordController.text = 'Bcoom!35';
    }
  }
}
