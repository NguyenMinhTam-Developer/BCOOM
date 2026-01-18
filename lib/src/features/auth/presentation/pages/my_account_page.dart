import 'dart:io';

import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:bcoom/src/shared/typography/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../core/services/session/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/device/image_picker_service.dart';
import '../../../../infrastructure/device/image_source_dialog.dart';
import '../../../location/presentation/controllers/location_controller.dart';
import '../controllers/my_account_controller.dart';

class MyAccountPage extends GetWidget<MyAccountController> {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SessionService.instance.currentUser.value;

    print(user?.avatarUrl);
    print(user?.identityCardImageFrontLink);
    print(user?.identityCardImageBackLink);

    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin tài khoản"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Obx(
            () => FormBuilder(
              key: controller.formKey,
              autovalidateMode: controller.autoValidateMode,
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Avatar at the top
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0F5), // Light pink background
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: _ProfileAvatarWidget(
                        onImagePicked: (image) {
                          controller.onAvatarPicked(image);
                        },
                        currentImage: controller.image.value,
                        initialNetworkImage: SessionService.instance.currentUser.value?.avatarUrl,
                      ),
                    ),
                  ),

                  Text(
                    "Thông tin tài khoản",
                  ),

                  FormBuilderTextField(
                    name: 'name',
                    textInputAction: TextInputAction.next,
                    initialValue: user?.fullName,
                    decoration: InputDecoration(
                      labelText: 'Họ & tên*',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Họ & tên không được để trống'),
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
                      labelText: 'Ngày sinh*',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Ngày sinh không được để trống'),
                    ]),
                  ),

                  // Gender selection
                  Obx(
                    () => FormBuilderDropdown<String>(
                      name: 'gender',
                      initialValue: controller.selectedGender.value,
                      decoration: InputDecoration(
                        labelText: 'Giới tính*',
                      ),
                      style: AppTextStyles.body14.copyWith(color: AppColors.text500),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'male',
                          child: Text('Nam'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'female',
                          child: Text('Nữ'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'other',
                          child: Text('Khác'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedGender.value = value;
                        }
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'Giới tính không được để trống'),
                      ]),
                    ),
                  ),

                  // Nationality dropdown
                  Builder(
                    builder: (context) {
                      try {
                        final locationController = Get.find<LocationController>();
                        return Obx(
                          () => FormBuilderDropdown<int>(
                            name: 'nationality',
                            initialValue: controller.selectedCountryId.value,
                            style: AppTextStyles.body14.copyWith(color: AppColors.text500),
                            decoration: InputDecoration(
                              labelText: 'Quốc gia*',
                            ),
                            items: locationController.countries.map((country) {
                              return DropdownMenuItem<int>(
                                value: country.countryId,
                                child: Text(country.nameWithType),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedCountryId.value = value;
                              }
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'Quốc gia không được để trống'),
                            ]),
                          ),
                        );
                      } catch (e) {
                        return FormBuilderDropdown<int>(
                          name: 'nationality',
                          decoration: InputDecoration(
                            labelText: 'Quốc gia*',
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          items: [],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Quốc gia không được để trống'),
                          ]),
                        );
                      }
                    },
                  ),

                  FormBuilderTextField(
                    name: 'phone',
                    readOnly: user?.phone != null,
                    enabled: user?.phone != null,
                    initialValue: user?.phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Điện thoại*',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Điện thoại không được để trống'),
                      FormBuilderValidators.numeric(errorText: 'Số điện thoại không hợp lệ'),
                    ]),
                  ),

                  FormBuilderTextField(
                    name: 'email',
                    readOnly: user?.email != null,
                    enabled: user?.email != null,
                    initialValue: user?.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Địa chỉ Email*',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Email không được để trống'),
                      FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
                    ]),
                  ),
                  // Citizen ID section
                  Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Căn cước công dân*',
                      ),
                      Text(
                        'Chụp mặt trước, mặt sau CMND/CCCD',
                      ),
                      Row(
                        spacing: 16.w,
                        children: [
                          Expanded(
                            child: Obx(
                              () => _IdentityImageWidget(
                                label: 'Mặt trước',
                                initialNetworkImage: SessionService.instance.currentUser.value?.identityCardImageFrontLink,
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
                              () => _IdentityImageWidget(
                                label: 'Mặt sau',
                                initialNetworkImage: SessionService.instance.currentUser.value?.identityCardImageBackLink,
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
                      ),
                    ],
                  ),

                  // Save button
                  FilledButton(
                    onPressed: controller.isLoading.value ? null : controller.onCompleteProfile,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text(
                      'Lưu cập nhật',
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

class _IdentityImageWidget extends StatelessWidget {
  final String label;
  final String? initialNetworkImage;
  final File? image;
  final Function(File?) onImagePicked;

  const _IdentityImageWidget({
    required this.label,
    required this.initialNetworkImage,
    required this.image,
    required this.onImagePicked,
  });

  Future<void> _handleImagePick(BuildContext context) async {
    final imagePickerService = ImagePickerService();

    await ImageSourceDialog.show(
      context: context,
      onCameraTap: () async {
        final pickedImage = await imagePickerService.pickImageFromCamera();
        if (pickedImage != null) {
          onImagePicked(pickedImage);
        }
      },
      onGalleryTap: () async {
        final pickedImage = await imagePickerService.pickImageFromGallery();
        if (pickedImage != null) {
          onImagePicked(pickedImage);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _handleImagePick(context),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFFFF0F5), // Light pink background
        ),
        height: 120.h,
        child: Builder(builder: (context) {
          if (image != null) {
            return Stack(
              children: [
                Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 8.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (initialNetworkImage != null) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: initialNetworkImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 8.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return DottedBorder(
            options: RoundedRectDottedBorderOptions(
              dashPattern: [3, 3],
              strokeWidth: 1,
              color: Colors.grey.withOpacity(0.3),
              radius: Radius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    label == 'Mặt trước' ? Icons.person : Icons.verified,
                    size: 32.w,
                    color: Colors.grey,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileAvatarWidget extends StatelessWidget {
  final Function(File) onImagePicked;
  final File? currentImage;
  final String? initialNetworkImage;

  const _ProfileAvatarWidget({
    required this.onImagePicked,
    this.currentImage,
    this.initialNetworkImage,
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
    return GestureDetector(
      onTap: () => _handleImagePick(context),
      child: Stack(
        children: [
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Builder(builder: (context) {
                if (currentImage != null) {
                  return Image.file(
                    currentImage!,
                    fit: BoxFit.cover,
                  );
                } else if (initialNetworkImage != null) {
                  return CachedNetworkImage(
                    imageUrl: initialNetworkImage!,
                    fit: BoxFit.cover,
                  );
                }
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 64.w,
                    color: Colors.grey[600],
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
