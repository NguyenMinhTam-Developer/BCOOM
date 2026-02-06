import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageLoadingIndicator(
        future: null,
        focedLoading: controller.isLoading.value,
        scaffold: Scaffold(
          appBar: AppBar(
              // title: Text('Quên mật khẩu'),
              ),
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
                    'Quên mật khẩu',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Obx(
                        () => FormBuilder(
                          key: controller.formKey,
                          autovalidateMode: controller.autoValidateMode,
                          child: Column(
                            spacing: 16.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputLabel(
                                label: 'Email',
                                child: FormBuilderTextField(
                                  name: 'email',
                                  controller: controller.emailController,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập email',
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(errorText: 'Email không được để trống'),
                                    FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
                                  ]),
                                  onSubmitted: (value) => controller.sendResetPasswordRequest(),
                                ),
                              ),
                              FilledButton(
                                onPressed: controller.isLoading.value ? null : controller.sendResetPasswordRequest,
                                child: Text('Gửi'),
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
