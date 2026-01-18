import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/routers/app_page_names.dart';
import '../../../../core/services/session/session_service.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/update_profile.dart';
import '../../domain/value_objects/customer_type.dart';

class ProfileCompletionController extends GetxController {
  final UpdateProfileUseCase _updateProfileUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final RxBool isLoading = false.obs;
  late final String? token;

  final Rx<File?> image = Rx<File?>(null);
  final Rx<File?> frontIdentityImage = Rx<File?>(null);
  final Rx<File?> backIdentityImage = Rx<File?>(null);
  final RxBool isAvatarChanged = false.obs;
  final RxBool isFrontIdentityChanged = false.obs;
  final RxBool isBackIdentityChanged = false.obs;
  final Rx<CustomerTypeEnum?> customerType = Rx<CustomerTypeEnum?>(CustomerTypeEnum.pharmacist);

  ProfileCompletionController({
    required UpdateProfileUseCase updateProfileUseCase,
  }) : _updateProfileUseCase = updateProfileUseCase;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is AuthResponse) {
      token = (Get.arguments as AuthResponse).data.token;
    }
  }

  Future<void> onCompleteProfile() async {
    isLoading.value = true;
    formKey.currentState!.saveAndValidate();
    autoValidateMode = AutovalidateMode.onUserInteraction;

    try {
      final authResponse = await _updateProfileUsecase();

      authResponse.fold(
        (failure) {
          switch (failure) {
            default:
              Get.snackbar('Cập nhật thông tin thất bại', failure.message, snackPosition: SnackPosition.TOP);
              break;
          }
        },
        (authResponse) async {
          image.value = null;
          frontIdentityImage.value = null;
          backIdentityImage.value = null;
          isAvatarChanged.value = false;
          isFrontIdentityChanged.value = false;
          isBackIdentityChanged.value = false;

          AppPageNames.navigateToHome();

          Get.snackbar(
            "Thông báo",
            "Cập nhật thông tin thành công",
            snackPosition: SnackPosition.TOP,
          );
        },
      );
    } catch (e) {
      Get.snackbar('Đăng ký thất bại', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Either<Failure, UserEntity>> _updateProfileUsecase() async {
    var params = UpdateProfileParams.create(
      avatar: isAvatarChanged.value ? image.value : null,
      name: formKey.currentState?.fields['name']?.value,
      birthday: formKey.currentState?.fields['date_of_birth']?.value,
      gender: SessionService.instance.currentUser.value?.gender,
      countryId: SessionService.instance.currentUser.value?.countryId,
      identityCardImageFront: isFrontIdentityChanged.value ? frontIdentityImage.value : null,
      identityCardImageBack: isBackIdentityChanged.value ? backIdentityImage.value : null,
      initialAvatarUrl: SessionService.instance.currentUser.value?.avatar,
      initialIdentityCardImageFrontUrl: SessionService.instance.currentUser.value?.identityCardImageFrontLink,
      initialIdentityCardImageBackUrl: SessionService.instance.currentUser.value?.identityCardImageBackLink,
    );

    return params.fold(
      (failure) => Left(failure),
      (validParams) => _updateProfileUseCase(validParams),
    );
  }

  void onAvatarPicked(File image) {
    this.image.value = image;
    isAvatarChanged.value = true;
  }

  void onFrontIdentityImagePicked(File image) {
    frontIdentityImage.value = image;
    isFrontIdentityChanged.value = true;
  }

  void onBackIdentityImagePicked(File image) {
    backIdentityImage.value = image;
    isBackIdentityChanged.value = true;
  }
}
