import 'package:bcoom/generated/assets.gen.dart';
import 'package:bcoom/src/shared/typography/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/services/session/session_service.dart';
import '../../../../shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends GetView<SessionService> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentUser.value == null) {
        return _buildUnauthenticatedLayout();
      } else {
        return _buildAuthenticatedLayout();
      }
    });
  }

  Widget _buildAuthenticatedLayout() {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250.h + (124 / 2).h,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 250.h,
                      child: Container(
                        child: Assets.svgs.authClientHeaderBackgroundPng.image(fit: BoxFit.fitWidth, height: 250.h),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 16.w,
                      right: 16.w,
                      height: 124.h,
                      child: Obx(
                        () {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 30.r,
                                  spreadRadius: 0,
                                  color: Colors.black.withValues(alpha: 0.1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8.h,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppPageNames.myAccount);
                                  },
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Row(
                                    spacing: 16.w,
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 50.h,
                                        padding: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          gradient: AppColors.primaryGradient,
                                          shape: BoxShape.circle,
                                          // image: DecorationImage(
                                          //   image: CachedNetworkImageProvider(controller.currentUser.value?.avatarUrl ?? ''),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: controller.currentUser.value?.avatarUrl ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          spacing: 4.h,
                                          children: [
                                            Text(
                                              controller.currentUser.value?.fullName ?? controller.currentUser.value?.email ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.heading6.copyWith(color: AppColors.text500),
                                            ),
                                            Text(
                                              'ID: ${controller.currentUser.value?.code}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                                            ),
                                            Text(
                                              controller.currentUser.value?.customerTypeName ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 24.w,
                                        color: AppColors.text200,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12.w, right: 8.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: AppColors.primaryGradient,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mã giới thiệu",
                                          style: AppTextStyles.body12.copyWith(color: Colors.white),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 12.w, right: 2.w),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(9999.r),
                                          ),
                                          child: Row(
                                            spacing: 16.w,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(maxWidth: 75.w),
                                                child: Text(
                                                  controller.currentUser.value?.code ?? '',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppTextStyles.heading4.copyWith(color: Colors.white),
                                                ),
                                              ),
                                              Card(
                                                shape: StadiumBorder(),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                                                  child: Text(
                                                    "Sao chép",
                                                    style: AppTextStyles.body10.copyWith(color: AppColors.primary500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20.h,
                  children: [
                    // Quản lý tài khoản section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12.h,
                      children: [
                        AccountSectionTitle(title: 'Quản lý tài khoản'),
                        AccountSectionHolder(
                          items: [
                            AccountItem(
                              icon: Icon(Symbols.receipt_long, size: 16.w, color: AppColors.text400),
                              title: 'Đơn hàng của tôi',
                              onTap: () {
                                AppPageNames.navigateToOrders();
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.refresh, size: 16.w, color: AppColors.text400),
                              title: 'Đổi trả',
                              onTap: () {
                                // TODO: Navigate to returns page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.location_on, size: 16.w, color: AppColors.text400),
                              title: 'Địa chỉ nhận hàng',
                              onTap: () {
                                AppPageNames.navigateToAddresses();
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.visibility, size: 16.w, color: AppColors.text400),
                              title: 'Sản phẩm đã xem',
                              onTap: () {
                                AppPageNames.navigateToViewedProducts();
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.favorite, size: 16.w, color: AppColors.text400),
                              title: 'Sản phẩm yêu thích',
                              onTap: () {
                                AppPageNames.navigateToWishlist();
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.stars, size: 16.w, color: AppColors.text400),
                              title: 'Điểm tích luỹ',
                              onTap: () {
                                // TODO: Navigate to points page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.confirmation_number, size: 16.w, color: AppColors.text400),
                              title: 'Mã ưu đãi',
                              onTap: () {
                                // TODO: Navigate to vouchers page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.account_balance_wallet, size: 16.w, color: AppColors.text400),
                              title: 'Số dư tài khoản',
                              onTap: () {
                                // TODO: Navigate to wallet page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.people, size: 16.w, color: AppColors.text400),
                              title: 'Quản lý khách hàng',
                              onTap: () {
                                // TODO: Navigate to customer management page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.card_giftcard, size: 16.w, color: AppColors.text400),
                              title: 'Mời bạn có thưởng',
                              onTap: () {
                                // TODO: Navigate to referral page
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.account_balance, size: 16.w, color: AppColors.text400),
                              title: 'Thông tin ngân hàng',
                              onTap: () {
                                AppPageNames.navigateToBanks();
                              },
                            ),
                            AccountItem(
                              icon: Icon(Symbols.headset_mic, size: 16.w, color: AppColors.text400),
                              title: 'Hỗ trợ khách hàng',
                              onTap: () {
                                AppPageNames.navigateToCustomerSupport();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Về BCOOM section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12.h,
                      children: [
                        AccountSectionTitle(title: 'Về BCOOM'),
                        AccountSectionHolder(
                          items: [
                            AccountItem(
                              icon: Icon(Symbols.business, size: 16.w, color: AppColors.text400),
                              title: 'Giới thiệu về BCOOM',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'gioi-thieu-ve-bcoom'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.account_balance_wallet, size: 16.w, color: AppColors.text400),
                              title: 'Giới thiệu về Bpoint',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'gioi-thieu-ve-bpoint'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.payment, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách bảo mật - Thanh toán',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-bao-mat-thanh-toan'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.privacy_tip, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách bảo mật thông tin',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-bao-mat-thong-tin'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.support_agent, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách hỗ trợ khiếu nại',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-ho-tro-khieu-nai'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.description, size: 16.w, color: AppColors.text400),
                              title: 'Điều khoản sử dụng',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'dieu-khoan-su-dung'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.local_shipping, size: 16.w, color: AppColors.text400),
                              title: 'Điều kiện vận chuyển',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'dieu-kien-van-chuyen'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Hỗ trợ bán hàng section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12.h,
                      children: [
                        AccountSectionTitle(title: 'Hỗ trợ khách hàng'),
                        AccountSectionHolder(
                          items: [
                            AccountItem(
                              icon: Icon(Symbols.shopping_cart_checkout, size: 16.w, color: AppColors.text400),
                              title: 'Hướng dẫn đặt hàng',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'huong-dan-dat-hang'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.local_shipping, size: 16.w, color: AppColors.text400),
                              title: 'Phương thức vận chuyển',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'phuong-thuc-van-chuyen'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.checklist, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách kiểm hàng',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-kiem-hang'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.assignment_return, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách đổi trả',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-doi-tra'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.inventory, size: 16.w, color: AppColors.text400),
                              title: 'Chính sách hàng nhập khẩu',
                              onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-hang-nhap-khau'),
                            ),
                            AccountItem(
                              icon: Icon(Symbols.help_outline, size: 16.w, color: AppColors.text400),
                              title: 'Câu hỏi thường gặp',
                              onTap: () => AppPageNames.navigateToFaqList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Logout button
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: AccountSectionHolder(
                        items: [
                          AccountItem(
                            icon: Icon(Symbols.logout, size: 16.w, color: Colors.red),
                            title: 'Đăng xuất',
                            onTap: () async {
                              await controller.logout();
                            },
                          ),
                        ],
                      ),
                    ),
                    // Hotline
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Center(
                        child: Column(
                          spacing: 4.h,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Symbols.phone, size: 16.w, color: Colors.red),
                                SizedBox(width: 8.w),
                                Text(
                                  "Hotline: ",
                                  style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                                ),
                                Text(
                                  "024 73010966",
                                  style: AppTextStyles.body12.copyWith(color: Colors.red),
                                ),
                                Text(
                                  " (08h00 - 17h00)",
                                  style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Phiên bản 1.0.0",
                              style: AppTextStyles.body12.copyWith(color: AppColors.text300),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildUnauthenticatedLayout() {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: Color(0xFF556080),
            shape: BoxShape.circle,
          ),
          child: Icon(Symbols.person, fill: 1, color: Colors.white, size: 32.w),
        ),
        actions: [
          Row(
            spacing: 12.w,
            children: [
              AppButton.outline(
                size: ButtonSize.small,
                label: 'Đăng nhập',
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                onPressed: () => Get.toNamed(AppPageNames.login),
              ),
              AppButton.primary(
                size: ButtonSize.small,
                label: 'Đăng ký',
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                onPressed: () => Get.toNamed(AppPageNames.roleSelection),
              ),
              SizedBox(width: 16.w),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20.h,
            children: [
              // Về BCOOM section
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12.h,
                children: [
                  AccountSectionTitle(title: 'Về BCOOM'),
                  AccountSectionHolder(
                    items: [
                      AccountItem(
                        icon: Icon(Symbols.business, size: 16.w, color: AppColors.text400),
                        title: 'Giới thiệu về BCOOM',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'gioi-thieu-ve-bcoom'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.account_balance_wallet, size: 16.w, color: AppColors.text400),
                        title: 'Giới thiệu về Bpoint',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'gioi-thieu-ve-bpoint'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.payment, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách bảo mật - Thanh toán',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-bao-mat-thanh-toan'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.privacy_tip, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách bảo mật thông tin',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-bao-mat-thong-tin'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.support_agent, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách hỗ trợ khiếu nại',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-ho-tro-khieu-nai'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.description, size: 16.w, color: AppColors.text400),
                        title: 'Điều khoản sử dụng',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'dieu-khoan-su-dung'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.local_shipping, size: 16.w, color: AppColors.text400),
                        title: 'Điều kiện vận chuyển',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'dieu-kien-van-chuyen'),
                      ),
                    ],
                  ),
                ],
              ),
              // Hỗ trợ bán hàng section
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12.h,
                children: [
                  AccountSectionTitle(title: 'Hỗ trợ khách hàng'),
                  AccountSectionHolder(
                    items: [
                      AccountItem(
                        icon: Icon(Symbols.shopping_cart_checkout, size: 16.w, color: AppColors.text400),
                        title: 'Hướng dẫn đặt hàng',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'huong-dan-dat-hang'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.local_shipping, size: 16.w, color: AppColors.text400),
                        title: 'Phương thức vận chuyển',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'phuong-thuc-van-chuyen'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.checklist, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách kiểm hàng',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-kiem-hang'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.assignment_return, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách đổi trả',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-doi-tra'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.inventory, size: 16.w, color: AppColors.text400),
                        title: 'Chính sách hàng nhập khẩu',
                        onTap: () => AppPageNames.navigateToPageView(slug: 'chinh-sach-hang-nhap-khau'),
                      ),
                      AccountItem(
                        icon: Icon(Symbols.help_outline, size: 16.w, color: AppColors.text400),
                        title: 'Câu hỏi thường gặp',
                        onTap: () => AppPageNames.navigateToFaqList(),
                      ),
                    ],
                  ),
                ],
              ),
              // Logout button
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Center(
                  child: Column(
                    spacing: 4.h,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Symbols.phone, size: 16.w, color: Colors.red),
                          SizedBox(width: 8.w),
                          Text(
                            "Hotline: ",
                            style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                          ),
                          Text(
                            "19001900",
                            style: AppTextStyles.body12.copyWith(color: Colors.red),
                          ),
                          Text(
                            " (08h00 - 17h00)",
                            style: AppTextStyles.body12.copyWith(color: AppColors.text400),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Phiên bản 1.0.0",
                        style: AppTextStyles.body12.copyWith(color: AppColors.text300),
                      ),
                    ],
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

class AccountSectionTitle extends StatelessWidget {
  const AccountSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
    );
  }
}

class AccountSectionHolder extends StatelessWidget {
  const AccountSectionHolder({
    super.key,
    required this.items,
  });
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) => items[index],
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Row(
            spacing: 12.w,
            children: [
              Container(
                height: 36.w,
                width: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.bg300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    height: 16.w,
                    width: 16.w,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: icon,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.text400,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.w, color: AppColors.text200),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountItemCard extends StatelessWidget {
  const AccountItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                  width: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.secondary500,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 14.h,
                      width: 14.h,
                      child: FittedBox(child: icon),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 4.h,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body12.copyWith(color: AppColors.text500),
                ),
                Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body12.copyWith(color: AppColors.text300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
