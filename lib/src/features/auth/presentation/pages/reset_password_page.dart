import 'package:bcoom/src/shared/components/input_label.dart';
import 'package:bcoom/src/shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
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
          appBar: AppBar(),
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
                    'Đặt lại mật khẩu',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text500,
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
                              // Password field
                              Column(
                                spacing: 8.h,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  InputLabel(
                                    label: 'Mật khẩu mới',
                                    child: FormBuilderTextField(
                                      name: 'password',
                                      controller: controller.passwordController,
                                      obscureText: !controller.isPasswordVisible.value,
                                      keyboardType: TextInputType.visiblePassword,
                                      onChanged: (value) {
                                        controller.passwordController.text = value ?? '';
                                      },
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(
                                          errorText: 'Vui lòng nhập mật khẩu mới',
                                        ),
                                        FormBuilderValidators.minLength(8, errorText: 'Mật khẩu phải có ít nhất 8 ký tự'),
                                        FormBuilderValidators.maxLength(30, errorText: 'Mật khẩu không được quá 30 ký tự'),
                                      ]),
                                      decoration: InputDecoration(
                                        hintText: 'Nhập mật khẩu mới của bạn',
                                        suffixIcon: IconButton(
                                          onPressed: controller.togglePasswordVisibility,
                                          icon: Icon(
                                            controller.isPasswordVisible.value ? Symbols.visibility : Symbols.visibility_off,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Mật khẩu mới phải có chữ HOA [A-Z], chữ thường [a-z], số [0-9] và từ 8 đến 30 ký tự.',
                                    style: AppTextStyles.body12.copyWith(color: AppColors.text200),
                                  ),
                                ],
                              ),
                              // Confirm password field
                              InputLabel(
                                label: 'Xác nhận mật khẩu',
                                child: FormBuilderTextField(
                                  name: 'confirm_password',
                                  controller: controller.passwordConfirmationController,
                                  obscureText: !controller.isPasswordConfirmationVisible.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (value) {
                                    controller.passwordConfirmationController.text = value ?? '';
                                  },
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: 'Vui lòng xác nhận mật khẩu',
                                    ),
                                  ]),
                                  decoration: InputDecoration(
                                    hintText: 'Nhập lại mật khẩu của bạn',
                                    suffixIcon: IconButton(
                                      onPressed: controller.togglePasswordConfirmationVisibility,
                                      icon: Icon(
                                        controller.isPasswordConfirmationVisible.value ? Symbols.visibility : Symbols.visibility_off,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Obx(
                              //   () => FormBuilderTextField(
                              //     name: 'password',
                              //     controller: controller.passwordController,
                              //     obscureText: !controller.isPasswordVisible.value,
                              //     textInputAction: TextInputAction.next,
                              //     decoration: InputDecoration(
                              //       labelText: 'Mật khẩu mới',
                              //       border: UnderlineInputBorder(),
                              //       prefixIcon: Icon(Symbols.key_rounded),
                              //       suffixIcon: IconButton(
                              //         onPressed: controller.togglePasswordVisibility,
                              //         icon: Icon(
                              //           controller.isPasswordVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                              //         ),
                              //       ),
                              //     ),
                              //     validator: FormBuilderValidators.compose([
                              //       FormBuilderValidators.required(errorText: 'Mật khẩu không được để trống'),
                              //       FormBuilderValidators.minLength(6, errorText: 'Mật khẩu phải có ít nhất 6 ký tự'),
                              //     ]),
                              //   ),
                              // ),
                              // Obx(
                              //   () => FormBuilderTextField(
                              //     name: 'passwordConfirmation',
                              //     controller: controller.passwordConfirmationController,
                              //     obscureText: !controller.isPasswordConfirmationVisible.value,
                              //     textInputAction: TextInputAction.done,
                              //     onSubmitted: (value) => controller.resetPassword(),
                              //     decoration: InputDecoration(
                              //       labelText: 'Xác nhận mật khẩu mới',
                              //       border: UnderlineInputBorder(),
                              //       prefixIcon: Icon(Symbols.key_rounded),
                              //       suffixIcon: IconButton(
                              //         onPressed: controller.togglePasswordConfirmationVisibility,
                              //         icon: Icon(
                              //           controller.isPasswordConfirmationVisible.value ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
                              //         ),
                              //       ),
                              //     ),
                              //     validator: FormBuilderValidators.compose([
                              //       FormBuilderValidators.required(errorText: 'Xác nhận mật khẩu không được để trống'),
                              //       (value) {
                              //         if (value != controller.passwordController.text) {
                              //           return 'Mật khẩu xác nhận không khớp';
                              //         }
                              //         return null;
                              //       },
                              //     ]),
                              //   ),
                              // ),
                              FilledButton(
                                onPressed: controller.isLoading.value ? null : controller.resetPassword,
                                child: Text('Cập nhật'),
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
