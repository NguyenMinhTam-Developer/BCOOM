import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                spacing: 24.h,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Hero(
                  //     tag: 'logo',
                  //     child: Assets.svgs.pharmacomSplashLogo.image(
                  //       width: 172.w,
                  //       height: 92.h,
                  //     ),
                  //   ),
                  // ),
                  Text(
                    'Thiết lập lại mật khẩu',
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
                              Obx(
                                () => FormBuilderTextField(
                                  name: 'password',
                                  controller: controller.passwordController,
                                  obscureText: !controller.isPasswordVisible.value,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Mật khẩu mới',
                                    border: UnderlineInputBorder(),
                                    prefixIcon: Icon(Symbols.key_rounded),
                                    suffixIcon: IconButton(
                                      onPressed: controller.togglePasswordVisibility,
                                      icon: Icon(
                                        controller.isPasswordVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                                      ),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Mật khẩu không được để trống'),
                                    FormBuilderValidators.minLength(6, errorText: 'Mật khẩu phải có ít nhất 6 ký tự'),
                                  ]),
                                ),
                              ),
                              Obx(
                                () => FormBuilderTextField(
                                  name: 'passwordConfirmation',
                                  controller: controller.passwordConfirmationController,
                                  obscureText: !controller.isPasswordConfirmationVisible.value,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) => controller.resetPassword(),
                                  decoration: InputDecoration(
                                    labelText: 'Xác nhận mật khẩu mới',
                                    border: UnderlineInputBorder(),
                                    prefixIcon: Icon(Symbols.key_rounded),
                                    suffixIcon: IconButton(
                                      onPressed: controller.togglePasswordConfirmationVisibility,
                                      icon: Icon(
                                        controller.isPasswordConfirmationVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                                      ),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Xác nhận mật khẩu không được để trống'),
                                    (value) {
                                      if (value != controller.passwordController.text) {
                                        return 'Mật khẩu xác nhận không khớp';
                                      }
                                      return null;
                                    },
                                  ]),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FilledButton(
                                  onPressed: controller.isLoading.value ? null : controller.resetPassword,
                                  child: Text('Tạo lại mật khẩu'),
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
