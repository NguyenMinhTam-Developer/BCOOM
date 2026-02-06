import '../../../../core/routers/app_page_names.dart';
import '../../../../shared/components/input_label.dart';

import '../../../../shared/components/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )),
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
          bottom: PreferredSize(preferredSize: Size.fromHeight(1.h), child: Container(color: AppColors.bg400)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Đăng nhập",
                style: AppTextStyles.heading2.copyWith(color: AppColors.text500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.h,
                children: [
                  // DefaultTabController(
                  //   length: 3,
                  //   child: TabBar(
                  //     indicatorSize: TabBarIndicatorSize.tab,
                  //     indicatorColor: AppColors.text500,
                  //     dividerColor: AppColors.bg500,
                  //     dividerHeight: 1.h,
                  //     labelPadding: EdgeInsets.zero,
                  //     labelStyle: AppTextStyles.body14.copyWith(color: AppColors.text500),
                  //     unselectedLabelStyle: AppTextStyles.body14.copyWith(color: AppColors.text300),
                  //     tabs: [
                  //       Tab(text: "Số điện thoại"),
                  //       // Tab(text: "Email"),
                  //       // Tab(text: "ID BCOOM"),
                  //     ],
                  //     onTap: (index) {
                  //       switch (index) {
                  //         case 0:
                  //           controller.selectedLoginMethod.value = LoginMethod.phone;
                  //           break;
                  //         case 1:
                  //           controller.selectedLoginMethod.value = LoginMethod.email;
                  //           break;
                  //         case 2:
                  //           controller.selectedLoginMethod.value = LoginMethod.idBcoom;
                  //           break;
                  //       }
                  //     },
                  //   ),
                  // ),
                  _buildLoginForm(),
                ],
              ),
              Obx(
                () => AppButton.primary(
                  onPressed: controller.isLoading.value ? null : controller.login,
                  label: controller.isLoading.value ? "Đang đăng nhập..." : "Đăng nhập",
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppPageNames.forgotPassword),
                child: Text(
                  "Quên mật khẩu?",
                  style: AppTextStyles.label14.copyWith(color: AppColors.text400),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Bạn chưa có tài khoản BCOOM? ",
                    style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                  ),
                  TextSpan(
                    text: "Đăng ký ngay",
                    style: AppTextStyles.heading6.copyWith(color: AppColors.primaryColor),
                    recognizer: TapGestureRecognizer()..onTap = controller.navigateToRegister,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildLoginForm() {
    return Obx(() {
      Widget child;
      switch (controller.selectedLoginMethod.value) {
        case LoginMethod.phone:
          child = _buildPhoneLoginForm();
          break;
        case LoginMethod.email:
          child = _buildEmailLoginForm();
          break;
        case LoginMethod.idBcoom:
          child = _buildIdBcoomLoginForm();
          break;
      }
      return FormBuilder(
        key: controller.formKey,
        autovalidateMode: controller.autoValidateMode,
        child: child,
      );
    });
  }

  Widget _buildPhoneLoginForm() {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Phone number input
        InputLabel(
          label: 'Số điện thoại',
          child: FormBuilderTextField(
            name: 'phone_number',
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Vui lòng nhập số điện thoại'),
              FormBuilderValidators.numeric(errorText: 'Số điện thoại không hợp lệ'),
            ]),
            decoration: InputDecoration(
              hintText: 'Nhập số điện thoại',
            ),
          ),
        ),
        _buildPasswordInput(),
      ],
    );
  }

  Widget _buildEmailLoginForm() {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email input
        InputLabel(
          label: 'Email',
          child: FormBuilderTextField(
            name: 'email',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Vui lòng nhập email'),
              FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
            ]),
            decoration: InputDecoration(
              hintText: 'Nhập địa chỉ email',
            ),
          ),
        ),

        _buildPasswordInput(),
      ],
    );
  }

  Widget _buildIdBcoomLoginForm() {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ID Bcoom input
        InputLabel(
          label: 'ID BCOOM',
          child: FormBuilderTextField(
            name: 'id_bcoom',
            controller: controller.idBcoomController,
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Vui lòng nhập ID BCOOM'),
            ]),
            decoration: InputDecoration(
              hintText: 'Nhập ID BCOOM của bạn',
            ),
          ),
        ),
        _buildPasswordInput(),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Obx(
      () => InputLabel(
        label: 'Mật khẩu',
        child: FormBuilderTextField(
          name: 'password',
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          keyboardType: TextInputType.visiblePassword,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Vui lòng nhập mật khẩu'),
          ]),
          decoration: InputDecoration(
            hintText: 'Nhập mật khẩu của bạn',
            suffixIcon: IconButton(
              onPressed: controller.togglePasswordVisibility,
              icon: Icon(controller.isPasswordVisible.value ? Symbols.visibility : Symbols.visibility_off),
            ),
          ),
        ),
      ),
    );
  }
}
