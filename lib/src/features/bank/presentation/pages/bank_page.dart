import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/bank_entity.dart';
import '../controllers/bank_controller.dart';
import 'create_bank_page.dart';

class BankPage extends GetView<BankController> {
  const BankPage({super.key});

  static void navigateTo() {
    AppPageNames.navigateToBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thông tin ngân hàng',
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.banks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Symbols.account_balance,
                  size: 64.w,
                  color: AppColors.text200,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Chưa có tài khoản ngân hàng nào',
                  style: AppTextStyles.body14.copyWith(color: AppColors.text300),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Thêm tài khoản ngân hàng để thanh toán nhanh chóng',
                  style: AppTextStyles.body12.copyWith(color: AppColors.text200),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.banks.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final bank = controller.banks[index];
            return _BankCard(
              bank: bank,
              onDelete: () {
                Get.dialog(
                  AlertDialog(
                    title: Text(
                      'Xóa tài khoản ngân hàng',
                      style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
                    ),
                    content: Text(
                      'Bạn có chắc chắn muốn xóa tài khoản ngân hàng này?',
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
                          controller.deleteBank(bank.id);
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
        onPressed: () {
          Get.to(() => const CreateBankPage());
        },
        backgroundColor: AppColors.primary500,
        icon: Icon(Symbols.add, color: Colors.white),
        label: Text(
          'Thêm ngân hàng',
          style: AppTextStyles.body14.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _BankCard extends StatelessWidget {
  const _BankCard({
    required this.bank,
    required this.onDelete,
  });

  final BankEntity bank;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: bank.isDefault
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
                if (bank.bankImageUrl != null && bank.bankImageLocation != null)
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.bg300,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        '${bank.bankImageUrl}${bank.bankImageLocation}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Symbols.account_balance,
                            size: 24.w,
                            color: AppColors.text300,
                          );
                        },
                      ),
                    ),
                  )
                else
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.bg300,
                    ),
                    child: Icon(
                      Symbols.account_balance,
                      size: 24.w,
                      color: AppColors.text300,
                    ),
                  ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4.h,
                    children: [
                      Text(
                        bank.bankName ?? 'Ngân hàng',
                        style: AppTextStyles.heading6.copyWith(color: AppColors.text500),
                      ),
                      if (bank.isDefault)
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
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
                    if (value == 'delete') {
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
                  Symbols.person,
                  size: 20.w,
                  color: AppColors.text400,
                ),
                Expanded(
                  child: Text(
                    bank.accountName,
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
                  Symbols.credit_card,
                  size: 20.w,
                  color: AppColors.text400,
                ),
                Expanded(
                  child: Text(
                    bank.accountNumber,
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
}
