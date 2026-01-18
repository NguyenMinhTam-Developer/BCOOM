import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/bank_controller.dart';

class CreateBankPage extends StatefulWidget {
  const CreateBankPage({super.key});

  @override
  State<CreateBankPage> createState() => _CreateBankPageState();
}

class _CreateBankPageState extends State<CreateBankPage> {
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int? selectedBankId;

  @override
  void dispose() {
    accountNumberController.dispose();
    accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BankController>();

    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thêm tài khoản ngân hàng',
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16.h,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 20.h),
              // // Bank dropdown
              InputLabel(
                label: 'Ngân hàng liên kết',
                isRequired: true,
                child: Obx(() {
                  if (controller.bankOptions.isEmpty) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.bg500),
                      ),
                      child: Text(
                        'Đang tải danh sách ngân hàng...',
                        style: AppTextStyles.body14.copyWith(color: AppColors.text300),
                      ),
                    );
                  }

                  return DropdownButtonFormField<int>(
                    value: selectedBankId,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
                    decoration: InputDecoration(
                      hintText: 'Chọn ngân hàng muốn liên kết',
                      hintStyle: AppTextStyles.body14.copyWith(color: AppColors.text200),
                      // suffixIcon: Icon(
                      //   Symbols.arrow_drop_down,
                      //   color: AppColors.text300,
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: AppColors.bg500),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: AppColors.text300),
                      ),
                    ),
                    isExpanded: true,
                    items: controller.bankOptions.map((bank) {
                      return DropdownMenuItem<int>(
                        value: bank.id,
                        child: Text(
                          bank.name,
                          style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBankId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Vui lòng chọn ngân hàng';
                      }
                      return null;
                    },
                  );
                }),
              ),

              // SizedBox(height: 20.h),

              // Account holder input
              InputLabel(
                label: 'Chủ tài khoản',
                isRequired: true,
                child: TextFormField(
                  controller: accountNameController,
                  decoration: InputDecoration(
                    hintText: 'Nhập họ và tên chủ tài khoản',
                    hintStyle: AppTextStyles.body14.copyWith(color: AppColors.text200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.bg500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.text300),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên chủ tài khoản';
                    }
                    return null;
                  },
                ),
              ),

              // SizedBox(height: 20.h),

              // Account number input
              InputLabel(
                label: 'Số tài khoản',
                isRequired: true,
                child: TextFormField(
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Nhập số tài khoản',
                    hintStyle: AppTextStyles.body14.copyWith(color: AppColors.text200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.bg500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.text300),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập số tài khoản';
                    }
                    return null;
                  },
                ),
              ),

              // SizedBox(height: 20.h),

              // Submit button
              AppButton.primary(
                label: 'Thêm ngân hàng',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (selectedBankId == null) {
                      Get.snackbar(
                        'Lỗi',
                        'Vui lòng chọn ngân hàng',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    controller.createBank(
                      bankId: selectedBankId!,
                      accountNumber: accountNumberController.text.trim(),
                      accountName: accountNameController.text.trim(),
                    );

                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
