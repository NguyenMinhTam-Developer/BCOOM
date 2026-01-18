import '../../../../shared/components/input_label.dart';

import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/gestures.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.bg200,
            actions: [
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: Row(
                    spacing: 5.w,
                    children: [
                      Icon(Symbols.language, size: 14.sp, color: AppColors.text500),
                      Text(
                        "Tiếng Anh",
                        style: AppTextStyles.label12.copyWith(
                          color: AppColors.text300,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Container(color: AppColors.bg400),
            ),
          ),
          body: FormBuilder(
            key: controller.formKey,
            autovalidateMode: controller.autoValidateMode,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SafeArea(
                child: Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Đăng ký",
                      style: AppTextStyles.heading2.copyWith(color: AppColors.text500),
                    ),

                    // Phone number input
                    InputLabel(
                      label: 'Số điện thoại',
                      child: FormBuilderTextField(
                        name: 'phone_number',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          controller.phoneController.text = value ?? '';
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập số điện thoại',
                          ),
                          FormBuilderValidators.numeric(
                            errorText: 'Số điện thoại không hợp lệ',
                          ),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Nhập số điện thoại',
                        ),
                      ),
                    ),
                    // Email field
                    InputLabel(
                      label: 'Email',
                      child: FormBuilderTextField(
                        name: 'email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          controller.emailController.text = value ?? '';
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập email',
                          ),
                          FormBuilderValidators.email(
                            errorText: 'Email không hợp lệ',
                          ),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Nhập địa chỉ email',
                        ),
                      ),
                    ),
                    // Full name field
                    InputLabel(
                      label: 'Họ và tên',
                      child: FormBuilderTextField(
                        name: 'full_name',
                        controller: controller.fullNameController,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          controller.fullNameController.text = value ?? '';
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập họ và tên',
                          ),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Nhập họ và tên đầy đủ',
                        ),
                      ),
                    ),
                    // Password field
                    Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputLabel(
                          label: 'Mật khẩu',
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
                                errorText: 'Vui lòng nhập mật khẩu',
                              ),
                              FormBuilderValidators.minLength(8, errorText: 'Mật khẩu phải có ít nhất 8 ký tự'),
                              FormBuilderValidators.maxLength(30, errorText: 'Mật khẩu không được quá 30 ký tự'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Nhập mật khẩu của bạn',
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
                          'Mật khẩu phải có chữ HOA [A-Z], chữ thường [a-z], số [0-9] và từ 8 đến 30 ký tự.',
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
                    // Referral code field (optional)
                    InputLabel(
                      label: 'Mã giới thiệu (bỏ qua nếu không có mã giới thiệu)',
                      child: FormBuilderTextField(
                        name: 'referral_code',
                        controller: controller.referralCodeController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          controller.referralCodeController.text = value ?? '';
                        },
                        decoration: InputDecoration(
                          hintText: 'Nhập mã giới thiệu',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                spacing: 16.h,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Register button
                  AppButton.primary(
                    onPressed: controller.isLoading.value ? null : controller.register,
                    label: controller.isLoading.value ? "Đang đăng ký..." : "Đăng ký",
                  ),

                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Bạn đã có tài khoản BCOOM? ",
                          style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                        ),
                        TextSpan(
                          text: "Đăng nhập ngay",
                          style: AppTextStyles.heading6.copyWith(
                            color: AppColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = controller.navigateToLogin,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                      children: [
                        TextSpan(
                          text: "Bằng việc Đăng ký, bạn đã đọc và đồng ý với BCOOM về ",
                        ),
                        TextSpan(
                          text: "Điều khoản dịch vụ",
                          style: AppTextStyles.body12.copyWith(
                            color: AppColors.text400,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: " và ",
                        ),
                        TextSpan(
                          text: "Chính sách bảo mật",
                          style: AppTextStyles.body12.copyWith(
                            color: AppColors.text400,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
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
