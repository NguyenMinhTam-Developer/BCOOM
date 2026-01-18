import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../address/domain/entities/address_entity.dart';
import '../../../address/presentation/controllers/address_controller.dart';
import '../controllers/cart_controller.dart';

class SelectShippingAddressPage extends GetView<AddressController> {
  const SelectShippingAddressPage({super.key});

  static Future<int?> navigateTo() async {
    final result = await Get.toNamed(AppPageNames.selectShippingAddress);
    if (result is int) {
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chọn địa chỉ giao hàng',
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
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Get.toNamed(AppPageNames.addressCreate);
                    if (result == true) {
                      controller.loadAddresses();
                    }
                  },
                  icon: Icon(Symbols.add, size: 20.w),
                  label: Text('Thêm địa chỉ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  ),
                ),
              ],
            ),
          );
        }

        final cartController = Get.find<CartController>();
        final selectedAddressId = cartController.cartInfo.value?.addressId ?? 0;

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.addresses.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final address = controller.addresses[index];
            final isSelected = address.id == selectedAddressId;

            return _SelectableAddressCard(
              address: address,
              isSelected: isSelected,
              onTap: () async {
                // Select this address and update cart (silently, no snackbar)
                await cartController.selectShippingAddressSilently(address.id);
                Get.back(result: address.id);
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

class _SelectableAddressCard extends StatelessWidget {
  const _SelectableAddressCard({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  final AddressEntity address;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
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
        child: Row(
          children: [
            // Radio button indicator
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary500 : AppColors.bg400,
                  width: 2.w,
                ),
                color: isSelected ? AppColors.primary500 : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Symbols.check,
                      size: 16.w,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 16.w),
            // Address info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8.h,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          address.name ?? 'Không có tên',
                          style: AppTextStyles.heading6.copyWith(
                            color: AppColors.text500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (address.isDefault)
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
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
                    ],
                  ),
                  Row(
                    spacing: 8.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Symbols.phone,
                        size: 16.w,
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
                        size: 16.w,
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
