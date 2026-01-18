import '../../../../core/routers/app_page_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserRole {
  retailCustomer, // Khách lẻ
  collaborator, // Cộng tác viên
  agent, // Đại lý
}

class RoleSelectionController extends GetxController {
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);
  final referralCodeController = TextEditingController();

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void proceed() {
    if (selectedRole.value == null) {
      Get.snackbar('Thông báo', 'Vui lòng chọn loại tài khoản', snackPosition: SnackPosition.TOP);
      return;
    }

    switch (selectedRole.value) {
      case UserRole.retailCustomer:
        Get.toNamed(AppPageNames.register, arguments: {'referralCode': referralCodeController.text.trim()});
        break;
      case UserRole.collaborator:
        Get.toNamed(AppPageNames.saleRegister, arguments: {
          'referralCode': referralCodeController.text.trim(),
          'customerType': 'colaborator',
        });
        break;
      case UserRole.agent:
        Get.toNamed(AppPageNames.saleRegister, arguments: {
          'referralCode': referralCodeController.text.trim(),
          'customerType': 'agent',
        });
        break;
      case null:
        break;
    }
  }

  void navigateToLogin() {
    Get.offNamed(AppPageNames.login);
  }

  @override
  void onClose() {
    referralCodeController.dispose();
    super.onClose();
  }
}
