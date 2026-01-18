import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

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
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Obx(
                        () => FormBuilder(
                          key: controller.formKey,
                          autovalidateMode: controller.autoValidateMode,
                          child: Column(
                            spacing: 16.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FormBuilderTextField(
                                name: 'phone',
                                controller: controller.emailController,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Số điện thoại',
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(Symbols.alternate_email_rounded),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Số điện thoại không được để trống'),
                                  FormBuilderValidators.numeric(errorText: 'Số điện thoại không hợp lệ'),
                                ]),
                                onSubmitted: (value) => controller.sendResetPasswordRequest(),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FilledButton(
                                  onPressed: controller.isLoading.value ? null : controller.sendResetPasswordRequest,
                                  child: Text('Gửi mã xác thực'),
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
