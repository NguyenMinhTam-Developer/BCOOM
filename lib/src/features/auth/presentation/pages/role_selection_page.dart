import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/gestures.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../controllers/role_selection_controller.dart';

class RoleSelectionPage extends GetView<RoleSelectionController> {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Greeting text
              Text(
                "Xin chào! Bạn muốn trở thành...",
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.text500,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),

              // Role selection buttons
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: _buildRoleButton(
                      title: "Khách lẻ",
                      icon: Symbols.person,
                      role: UserRole.retailCustomer,
                    ),
                  ),
                  Expanded(
                    child: _buildRoleButton(
                      title: "Cộng tác viên",
                      icon: Symbols.handshake,
                      role: UserRole.collaborator,
                    ),
                  ),
                  // Expanded(
                  //   child: _buildRoleButton(
                  //     title: "Đại lý",
                  //     icon: Symbols.store,
                  //     role: UserRole.agent,
                  //   ),
                  // ),
                ],
              ),

              // Benefits and referral code section (shown when role is selected)
              Obx(
                () => controller.selectedRole.value != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 24.h,
                        children: [
                          SizedBox(height: 24.h),
                          // Benefits section
                          _buildBenefitsSection(controller.selectedRole.value!),
                          // Referral code input
                          _buildReferralCodeInput(),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: [
              AppButton.primary(
                onPressed: controller.proceed,
                label: "Tiếp theo",
              ),
              RichText(
                textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required IconData icon,
    required UserRole role,
  }) {
    return Obx(() {
      final isSelected = controller.selectedRole.value == role;
      return InkWell(
        onTap: () => controller.selectRole(role),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 120.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.bg400,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.h,
            children: [
              Icon(
                icon,
                size: 32.sp,
                color: isSelected ? AppColors.primaryColor : AppColors.text400,
              ),
              Text(
                title,
                style: AppTextStyles.body12.copyWith(
                  color: isSelected ? AppColors.primaryColor : AppColors.text400,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBenefitsSection(UserRole role) {
    final benefits = _getBenefitsForRole(role);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: benefits
          .map((benefit) => _buildBenefitItem(
                title: benefit['title']!,
                description: benefit['description']!,
              ))
          .toList(),
    );
  }

  Widget _buildBenefitItem({
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Symbols.check_circle,
          color: Colors.green,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                title,
                style: AppTextStyles.body14.copyWith(
                  color: AppColors.text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.body12.copyWith(
                  color: AppColors.text400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReferralCodeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: [
        Text(
          "Mã giới thiệu",
          style: AppTextStyles.body14.copyWith(
            color: AppColors.text500,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextField(
          controller: controller.referralCodeController,
          decoration: InputDecoration(
            hintText: "Ví dụ: ON123AB47",
            hintStyle: AppTextStyles.body14.copyWith(color: AppColors.text300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.bg400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.bg400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
        Text(
          "Bỏ qua nếu không có mã giới thiệu",
          style: AppTextStyles.body12.copyWith(color: AppColors.text300),
        ),
      ],
    );
  }

  List<Map<String, String>> _getBenefitsForRole(UserRole role) {
    switch (role) {
      case UserRole.retailCustomer:
        return [
          {
            'title': 'Hàng chất giá rẻ',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
          {
            'title': 'Cơ hội kiếm tiền',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
        ];
      case UserRole.collaborator:
        return [
          {
            'title': 'Hoa hồng hấp dẫn',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
          {
            'title': 'Hỗ trợ marketing',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
        ];
      case UserRole.agent:
        return [
          {
            'title': 'Giá đại lý ưu đãi',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
          {
            'title': 'Hỗ trợ kinh doanh',
            'description': 'Lorem ipsum dolor sit amet consectetur',
          },
        ];
    }
  }
}
