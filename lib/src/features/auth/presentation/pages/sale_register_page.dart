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
import '../controllers/sale_register_controller.dart';
import '../../../../features/location/presentation/controllers/location_controller.dart';

class SaleRegisterPage extends GetView<SaleRegisterController> {
  const SaleRegisterPage({super.key});

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
                    // Province code field
                    Builder(
                      builder: (context) {
                        try {
                          final locationController = Get.find<LocationController>();
                          return Obx(
                            () => InputLabel(
                              label: 'Tỉnh/Thành phố',
                              child: FormBuilderDropdown<String>(
                                name: 'province_code',
                                initialValue: controller.selectedProvinceCode.value,
                                decoration: InputDecoration(
                                  hintText: 'Chọn tỉnh/thành phố',
                                  suffixIcon: Icon(Symbols.arrow_drop_down),
                                ),
                                items: locationController.provinces.map((province) {
                                  return DropdownMenuItem<String>(
                                    value: province.provinceCode,
                                    child: Text(province.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectedProvinceCode.value = value;
                                },
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                    errorText: 'Vui lòng chọn tỉnh/thành phố',
                                  ),
                                ]),
                              ),
                            ),
                          );
                        } catch (e) {
                          return InputLabel(
                            label: 'Tỉnh/Thành phố',
                            child: FormBuilderTextField(
                              name: 'province_code',
                              controller: controller.provinceCodeController,
                              decoration: InputDecoration(
                                hintText: 'Nhập mã tỉnh/thành phố',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Vui lòng nhập mã tỉnh/thành phố',
                                ),
                              ]),
                            ),
                          );
                        }
                      },
                    ),
                    // Job field
                    InputLabel(
                      label: 'Nghề nghiệp',
                      child: FormBuilderTextField(
                        name: 'job',
                        controller: controller.jobController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          controller.jobController.text = value ?? '';
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập nghề nghiệp',
                          ),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Nhập nghề nghiệp',
                        ),
                      ),
                    ),
                    // Note field
                    InputLabel(
                      label: 'Lời nhắn',
                      child: FormBuilderTextField(
                        name: 'note',
                        controller: controller.noteController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        onChanged: (value) {
                          controller.noteController.text = value ?? '';
                        },
                        decoration: InputDecoration(
                          hintText: 'Nhập lời nhắn (tùy chọn)',
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
