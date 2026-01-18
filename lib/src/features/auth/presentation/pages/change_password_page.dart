import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          appBar: AppBar(
            title: Text('Đổi mật khẩu'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Symbols.arrow_back_rounded),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                spacing: 24.h,
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Assets.svgs.pharmacomSplashLogo.image(
                  //     width: 172.w,
                  //     height: 92.h,
                  //   ),
                  // ),
                  Text(
                    'Đổi mật khẩu',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Obx(
                        () => FormBuilder(
                          key: controller.formKey,
                          autovalidateMode: controller.autoValidateMode,
                          child: Column(
                            spacing: 16.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Old Password Field
                              FormBuilderTextField(
                                name: 'oldPassword',
                                controller: controller.oldPasswordController,
                                obscureText: !controller.isOldPasswordVisible.value,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu cũ',
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(Symbols.key_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: controller.toggleOldPasswordVisibility,
                                    icon: Icon(
                                      controller.isOldPasswordVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Mật khẩu cũ không được để trống'),
                                ]),
                              ),
                              // New Password Field
                              FormBuilderTextField(
                                name: 'newPassword',
                                controller: controller.newPasswordController,
                                obscureText: !controller.isNewPasswordVisible.value,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu mới',
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(Symbols.key_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: controller.toggleNewPasswordVisibility,
                                    icon: Icon(
                                      controller.isNewPasswordVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Mật khẩu mới không được để trống'),
                                  FormBuilderValidators.minLength(6, errorText: 'Mật khẩu phải có ít nhất 6 ký tự'),
                                ]),
                              ),
                              // Confirm Password Field
                              FormBuilderTextField(
                                name: 'confirmPassword',
                                controller: controller.confirmPasswordController,
                                obscureText: !controller.isConfirmPasswordVisible.value,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) => controller.changePassword(),
                                decoration: InputDecoration(
                                  labelText: 'Xác nhận mật khẩu mới',
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(Symbols.key_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: controller.toggleConfirmPasswordVisibility,
                                    icon: Icon(
                                      controller.isConfirmPasswordVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Xác nhận mật khẩu không được để trống'),
                                  (value) {
                                    if (value != controller.newPasswordController.text) {
                                      return 'Mật khẩu xác nhận không khớp';
                                    }
                                    return null;
                                  },
                                ]),
                              ),
                              SizedBox(height: 24.h),
                              // Submit Button
                              Align(
                                alignment: Alignment.center,
                                child: FilledButton(
                                  onPressed: controller.isLoading.value ? null : controller.changePassword,
                                  child: Text('Đổi mật khẩu'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
