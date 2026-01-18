import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/routers/app_page_names.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/usecases/register_cooperation_usecase.dart';

class SaleRegisterController extends GetxController {
  final RegisterCooperationUseCase _registerCooperationUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  var autoValidateMode = AutovalidateMode.disabled;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final referralCodeController = TextEditingController();
  final provinceCodeController = TextEditingController();
  final jobController = TextEditingController();
  final noteController = TextEditingController();

  final Rx<String?> selectedProvinceCode = Rx<String?>(null);
  final RxString customerType = ''.obs;

  final RxBool isLoading = false.obs;
  final Rx<AuthData?> _authData = Rx<AuthData?>(null);

  SaleRegisterController({
    required RegisterCooperationUseCase registerCooperationUseCase,
  }) : _registerCooperationUseCase = registerCooperationUseCase;

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

          // Navigate to login with pending approval message
          Get.offAllNamed(AppPageNames.login);
          Get.snackbar(
            'Thông báo',
            'Tài khoản của bạn đang chờ được phê duyệt. Vui lòng đợi quản trị viên xác nhận.',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
          );
        },
      );
    } catch (e) {
      Get.snackbar('Đăng ký thất bại', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Either<Failure, AuthResponse>> _registerMethod() async {
    if (customerType.value.isEmpty) {
      return Left(InputValidationFailure(message: 'Loại tài khoản không hợp lệ'));
    }

    final provinceCode = selectedProvinceCode.value;
    if (provinceCode == null || provinceCode.isEmpty) {
      return Left(InputValidationFailure(message: 'Vui lòng chọn tỉnh/thành phố'));
    }

    final params = RegisterCooperationParams(
      customerType: customerType.value,
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      provinceCode: provinceCode,
      job: jobController.text.trim(),
      note: noteController.text.trim(),
    );

    return await _registerCooperationUseCase(params);
  }

  void navigateToLogin() {
    Get.offNamed(AppPageNames.login);
  }

  @override
  void onInit() {
    super.onInit();

    // Get customer type and referral code from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map) {
      if (arguments['referralCode'] != null) {
        referralCodeController.text = arguments['referralCode'] as String;
      }
      // Get customer type from role selection
      // collaborator -> "colaborator", agent -> "agent"
      if (arguments['customerType'] != null) {
        customerType.value = arguments['customerType'] as String;
      }
    }

    if (kDebugMode) {
      phoneController.text = '0936235171';
      emailController.text = 'tinhdev@gmail.com';
      fullNameController.text = 'Tên CTV';
      jobController.text = 'lập trình';
      noteController.text = 'lời nhắn';
    }
  }

  @override
  void onClose() {
    provinceCodeController.dispose();
    jobController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
