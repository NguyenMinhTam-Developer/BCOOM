import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/address_entity.dart';
import '../controllers/address_controller.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  static void navigateTo() {
    AppPageNames.navigateToAddresses();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Địa chỉ nhận hàng',
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Symbols.location_on,
                  size: 64.w,
                  color: AppColors.text200,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Chưa có địa chỉ nào',
                  style: AppTextStyles.body14.copyWith(color: AppColors.text300),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Thêm địa chỉ để nhận hàng nhanh chóng',
                  style: AppTextStyles.body12.copyWith(color: AppColors.text200),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.addresses.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final address = controller.addresses[index];
            return _AddressCard(
              address: address,
              onTap: () {
                // TODO: Navigate to address detail/edit page
              },
              onSetDefault: address.isDefault
                  ? null
                  : () {
                      controller.setDefaultAddress(address.id);
                    },
              onEdit: () async {
                final result = await Get.toNamed(
                  AppPageNames.addressEdit.replaceAll(':id', address.id.toString()),
                );
                if (result == true) {
                  controller.loadAddresses();
                }
              },
              onDelete: () {
                Get.dialog(
                  AlertDialog(
                    title: Text(
                      'Xóa địa chỉ',
                      style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
                    ),
                    content: Text(
                      'Bạn có chắc chắn muốn xóa địa chỉ này?',
                      style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Hủy',
                          style: AppTextStyles.body14.copyWith(color: AppColors.text300),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          controller.deleteAddress(address.id);
                        },
                        child: Text(
                          'Xóa',
                          style: AppTextStyles.body14.copyWith(color: AppColors.error500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Get.toNamed(AppPageNames.addressCreate);
          if (result == true) {
            controller.loadAddresses();
          }
        },
        backgroundColor: AppColors.primary500,
        icon: Icon(Symbols.add, color: Colors.white),
        label: Text(
          'Thêm địa chỉ',
          style: AppTextStyles.body14.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.onTap,
    this.onSetDefault,
    required this.onDelete,
    this.onEdit,
  });

  final AddressEntity address;
  final VoidCallback onTap;
  final VoidCallback? onSetDefault;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: address.isDefault
              ? Border.all(color: AppColors.primary500, width: 2.w)
              : Border.all(color: AppColors.bg400, width: 1.w),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8.r,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.h,
          children: [
            Row(
              children: [
                Icon(
                  Symbols.person,
                  size: 20.w,
                  color: AppColors.text400,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    address.name ?? 'Không có tên',
                    style: AppTextStyles.heading6.copyWith(color: AppColors.text500),
                  ),
                ),
                if (address.isDefault)
                  Container(
                    margin: EdgeInsets.only(left: 8.w, right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'Mặc định',
                      style: AppTextStyles.body10.copyWith(color: AppColors.primary500),
                    ),
                  ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Symbols.more_vert,
                    size: 20.w,
                    color: AppColors.text400,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  itemBuilder: (context) => [
                    if (onEdit != null)
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          spacing: 8.w,
                          children: [
                            Icon(
                              Symbols.edit,
                              size: 16.w,
                              color: AppColors.text400,
                            ),
                            Text(
                              'Chỉnh sửa',
                              style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                            ),
                          ],
                        ),
                      ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        spacing: 8.w,
                        children: [
                          Icon(
                            Symbols.delete_outline,
                            size: 16.w,
                            color: AppColors.error500,
                          ),
                          Text(
                            'Xóa',
                            style: AppTextStyles.body14.copyWith(color: AppColors.error500),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit' && onEdit != null) {
                      onEdit!();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Symbols.phone,
                  size: 20.w,
                  color: AppColors.text400,
                ),
                Expanded(
                  child: Text(
                    address.phone ?? 'Chưa có số điện thoại',
                    style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Symbols.location_on,
                  size: 20.w,
                  color: AppColors.text400,
                ),
                Expanded(
                  child: Text(
                    _buildAddressString(),
                    style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildAddressString() {
    final parts = <String>[];
    if (address.street != null && address.street!.isNotEmpty) {
      parts.add(address.street!);
    }
    if (address.ward != null) {
      parts.add(address.ward!.name);
    }
    if (address.province != null) {
      parts.add(address.province!.name);
    }
    return parts.isEmpty ? 'Chưa có địa chỉ' : parts.join(', ');
  }
}
