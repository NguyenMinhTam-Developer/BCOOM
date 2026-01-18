import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/services/session/session_service.dart';

import '../../../../infrastructure/device/image_picker_service.dart';
import '../../../../infrastructure/device/image_source_dialog.dart';
import '../../domain/value_objects/customer_type.dart';
import '../controllers/profile_completion_controller.dart';
import '../widgets/image_picker_button.dart';

class ProfileCompletionPage extends StatefulWidget {
  const ProfileCompletionPage({super.key});

  @override
  State<ProfileCompletionPage> createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  final controller = Get.find<ProfileCompletionController>();
  final user = SessionService.instance.currentUser.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            spacing: 24.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                'Hoàn tất hồ sơ cá nhân',
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
                            () => ImagePickerButton(
                              onImagePicked: (image) {
                                controller.onAvatarPicked(image);
                              },
                              currentImage: controller.image.value,
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'name',
                            textInputAction: TextInputAction.next,
                            initialValue: user?.fullName,
                            decoration: InputDecoration(
                              labelText: 'Tên hiển thị',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Tên hiển thị không được để trống'),
                            ]),
                          ),
                          FormBuilderDateTimePicker(
                            name: 'date_of_birth',
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            initialValue: user?.birthday,
                            format: DateFormat('dd/MM/yyyy'),
                            inputType: InputType.date,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Ngày sinh',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.cake_outlined),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Ngày sinh không được để trống'),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'email',
                            readOnly: user?.email != null,
                            initialValue: user?.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'phone',
                            readOnly: user?.phone != null,
                            initialValue: user?.phone,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Số điện thoại',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.phone_android_outlined),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Số điện thoại không được để trống'),
                              FormBuilderValidators.numeric(errorText: 'Số điện thoại không hợp lệ'),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'identity_number',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            initialValue: user?.identityCard,
                            decoration: InputDecoration(
                              labelText: 'Số CCCD',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.credit_card_outlined),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(errorText: 'Số CCCD không hợp lệ', checkNullOrEmpty: false),
                            ]),
                          ),
                          FormBuilderDateTimePicker(
                            name: 'identity_date',
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            initialValue: user?.identityCardAt,
                            format: DateFormat('dd/MM/yyyy'),
                            inputType: InputType.date,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Ngày cấp',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                            validator: FormBuilderValidators.compose([]),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 16.h,
                            children: [
                              Obx(
                                () {
                                  final String? frontImageName = controller.frontIdentityImage.value?.path.split('/').last;
                                  final String? backImageName = controller.backIdentityImage.value?.path.split('/').last;

                                  return FormBuilderTextField(
                                    name: 'identity_images',
                                    initialValue: [frontImageName, backImageName].where((element) => element != null).join(', '),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'Hình ảnh CCCD',
                                      border: UnderlineInputBorder(),
                                      prefixIcon: Icon(Icons.credit_card_outlined),
                                    ),
                                  );
                                },
                              ),
                              Row(
                                spacing: 16.w,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => IdentityImageWidget(
                                        initialNetworkImge: null,
                                        image: controller.frontIdentityImage.value,
                                        onImagePicked: (image) {
                                          if (image != null) {
                                            controller.onFrontIdentityImagePicked(image);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => IdentityImageWidget(
                                        initialNetworkImge: null,
                                        image: controller.backIdentityImage.value,
                                        onImagePicked: (image) {
                                          if (image != null) {
                                            controller.onBackIdentityImagePicked(image);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingOnly(left: 52.w),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 16.h,
                            children: [
                              Obx(
                                () {
                                  final customerType = controller.customerType.value;
                                  final customerTypeText = customerType == CustomerTypeEnum.pharmacist ? 'Dược sĩ' : 'Chủ nhà thuốc';

                                  return FormBuilderTextField(
                                    name: 'customer_type',
                                    controller: TextEditingController(text: customerTypeText),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'Bạn là',
                                      border: UnderlineInputBorder(),
                                      prefixIcon: Icon(Icons.work_outline_rounded),
                                    ),
                                  );
                                },
                              ),
                              Row(
                                spacing: 16.w,
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: CustomerTypeWidget(
                                        customerType: CustomerTypeEnum.pharmacist,
                                        currentCustomerType: controller.customerType.value,
                                        onCustomerTypeChanged: (customerType) {
                                          controller.customerType.value = customerType;
                                        },
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Expanded(
                                      child: CustomerTypeWidget(
                                        customerType: CustomerTypeEnum.pharmacy,
                                        currentCustomerType: controller.customerType.value,
                                        onCustomerTypeChanged: (customerType) {
                                          controller.customerType.value = customerType;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingOnly(left: 52.w),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Align(
                            alignment: Alignment.center,
                            child: FilledButton(
                              onPressed: controller.isLoading.value ? null : controller.onCompleteProfile,
                              child: Text('Hoàn tất hồ sơ'),
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
    );
  }
}

class IdentityImageWidget extends StatelessWidget {
  final String? initialNetworkImge;
  final File? image;
  final Function(File?) onImagePicked;

  const IdentityImageWidget({
    super.key,
    required this.initialNetworkImge,
    required this.image,
    required this.onImagePicked,
  });

  Future<void> _handleImagePick(BuildContext context) async {
    final imagePickerService = ImagePickerService();

    await ImageSourceDialog.show(
      context: context,
      onCameraTap: () async {
        final image = await imagePickerService.pickImageFromCamera();
        if (image != null) {
          onImagePicked(image);
        }
      },
      onGalleryTap: () async {
        final image = await imagePickerService.pickImageFromGallery();
        if (image != null) {
          onImagePicked(image);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        _handleImagePick(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        height: 75.h,
        child: Builder(builder: (context) {
          if (image != null) {
            return Image.file(
              image!,
              fit: BoxFit.cover,
            );
          } else if (initialNetworkImge != null) {
            return CachedNetworkImage(
              imageUrl: initialNetworkImge!,
              fit: BoxFit.cover,
            );
          }

          return DottedBorder(
            options: RoundedRectDottedBorderOptions(
              dashPattern: [3, 3],
              strokeWidth: 1,
              color: Color(0xFF212121).withValues(alpha: 0.3),
              radius: Radius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.upload_rounded,
                color: Color(0xFF212121).withValues(alpha: 0.3),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomerTypeWidget extends StatelessWidget {
  final CustomerTypeEnum customerType;
  final CustomerTypeEnum? currentCustomerType;
  final Function(CustomerTypeEnum) onCustomerTypeChanged;

  const CustomerTypeWidget({
    super.key,
    required this.customerType,
    required this.currentCustomerType,
    required this.onCustomerTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentCustomerType == customerType;
    Color backgroundColor = isSelected ? Color(0xFF263238) : Color(0xFFE0E0E0);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onCustomerTypeChanged(customerType);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        height: 75.h,
        child: Stack(
          children: [
            Positioned(
              right: 8.w,
              top: 8.h,
              bottom: 8.h,
              child: Icon(
                customerType == CustomerTypeEnum.pharmacist ? Symbols.pill_rounded : Symbols.storefront_rounded,
                color: Colors.white.withValues(alpha: 0.2),
                size: 56.h,
                fill: 0,
              ),
            ),
            Center(
              child: Text(
                customerType.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
