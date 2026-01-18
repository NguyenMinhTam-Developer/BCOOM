import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../location/presentation/controllers/location_controller.dart';
import '../controllers/create_address_controller.dart';

class CreateAddressPage extends GetView<CreateAddressController> {
  const CreateAddressPage({super.key});

  static void navigateTo() {
    Get.toNamed(AppPageNames.addressCreate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thêm địa chỉ mới',
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        elevation: 0,
      ),
      body: FormBuilder(
        key: controller.formKey,
        autovalidateMode: controller.autoValidateMode,
        initialValue: {
          'address_type': 'home', // Default to home
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: SafeArea(
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Full name field
                InputLabel(
                  label: 'Họ tên người nhận',
                  isRequired: true,
                  child: FormBuilderTextField(
                    name: 'name',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Nhập họ và tên người nhận',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(Symbols.person, color: AppColors.text400),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Vui lòng nhập họ và tên người nhận',
                      ),
                    ]),
                  ),
                ),

                // Phone field
                InputLabel(
                  label: 'Số điện thoại',
                  isRequired: true,
                  child: FormBuilderTextField(
                    name: 'phone',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Nhập số điện thoại',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(Symbols.phone, color: AppColors.text400),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Vui lòng nhập số điện thoại',
                      ),
                    ]),
                  ),
                ),

                // Province selection
                Builder(
                  builder: (context) {
                    try {
                      final locationController = Get.find<LocationController>();
                      return Obx(
                        () => InputLabel(
                          label: 'Tỉnh/Thành Phố',
                          isRequired: true,
                          child: FormBuilderDropdown<String>(
                            name: 'province_code',
                            decoration: InputDecoration(
                              hintText: 'Chọn Tỉnh/ Thành Phố',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              prefixIcon: Icon(Symbols.map, color: AppColors.text400),
                              suffixIcon: Icon(Symbols.arrow_drop_down, color: AppColors.text400),
                            ),
                            items: locationController.provinces.map((province) {
                              return DropdownMenuItem<String>(
                                value: province.provinceCode,
                                child: Text(
                                  province.name,
                                  style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.onProvinceChanged(value);
                              // Also update form field value
                              controller.formKey.currentState?.fields['province_code']?.didChange(value);
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
                        label: 'Tỉnh/Thành Phố',
                        isRequired: true,
                        child: FormBuilderTextField(
                          name: 'province_code',
                          decoration: InputDecoration(
                            hintText: 'Nhập mã tỉnh/thành phố',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
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

                // Ward selection
                Obx(
                  () => controller.selectedProvinceCode.value == null
                      ? const SizedBox.shrink()
                      : Obx(
                          () => InputLabel(
                            label: 'Phường/Xã',
                            isRequired: true,
                            child: FormBuilderDropdown<String>(
                              name: 'ward_code',
                              decoration: InputDecoration(
                                hintText: 'Chọn Phường/ Xã',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                prefixIcon: Icon(Symbols.location_city, color: AppColors.text400),
                                suffixIcon: Icon(Symbols.arrow_drop_down, color: AppColors.text400),
                              ),
                              items: controller.availableWards.map((ward) {
                                return DropdownMenuItem<String>(
                                  value: ward.wardCode,
                                  child: Text(
                                    ward.name,
                                    style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.selectedWardCode.value = value;
                                // Also update form field value
                                controller.formKey.currentState?.fields['ward_code']?.didChange(value);
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Vui lòng chọn phường/xã',
                                ),
                              ]),
                            ),
                          ),
                        ),
                ),

                // Street/Address field
                InputLabel(
                  label: 'Địa chỉ',
                  isRequired: true,
                  child: FormBuilderTextField(
                    name: 'street',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Nhập địa chỉ, đường, hèm, số nhà...vv',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(Symbols.location_on, color: AppColors.text400),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Vui lòng nhập địa chỉ',
                      ),
                    ]),
                  ),
                ),

                // Note field
                InputLabel(
                  label: 'Ghi chú',
                  child: FormBuilderTextField(
                    name: 'note',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Ghi chú cho tài xế (tùy chọn)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      prefixIcon: Icon(Symbols.note, color: AppColors.text400),
                    ),
                  ),
                ),

                // Address type selection
                InputLabel(
                  label: 'Loại địa chỉ:',
                  child: FormBuilderRadioGroup<String>(
                    name: 'address_type',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    options: [
                      FormBuilderFieldOption<String>(
                        value: 'home',
                        child: Text(
                          'Nhà riêng',
                          style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                        ),
                      ),
                      FormBuilderFieldOption<String>(
                        value: 'office',
                        child: Text(
                          'Văn phòng',
                          style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                        ),
                      ),
                    ],
                  ),
                ),

                // Set as default checkbox
                FormBuilderCheckbox(
                  name: 'is_default',
                  title: Text(
                    'Đặt làm địa chỉ mặc định',
                    style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 8.r,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.isLoading.value ? null : () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(color: AppColors.bg400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Huỷ bỏ',
                    style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      controller.isLoading.value ? 'Đang xử lý...' : 'Lưu địa chỉ mới',
                      style: AppTextStyles.body14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
