import '../widgets/home_element_academy.dart';
import '../widgets/home_element_brand.dart';
import '../widgets/home_element_community.dart';
import '../widgets/home_element_flash_deal.dart';
import '../widgets/home_element_home_banners.dart';
import '../widgets/home_element_luxury.dart';
import '../widgets/home_element_product.dart';
import '../widgets/home_element_top_deal.dart';

import '../../../auth/presentation/pages/account_page.dart';
import '../../../order/presentation/pages/order_list_page.dart';
import '../../../sales/presentation/pages/sales_page.dart';
import '../../../../core/routers/app_page_names.dart';
import '../../../../core/services/session/session_service.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          final sessionService = Get.find<SessionService>();
          final isCustomer = sessionService.currentUser.value?.customerType == 'customer';

          return IndexedStack(
            index: controller.currentIndex.value,
            children: [
              _HomePage(),
              const CatalogPage(),
              isCustomer ? const OrderListPage() : const SalesPage(),
              AccountPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 90.h,
            width: double.infinity,
            child: Stack(
              children: [
                // Positioned.fill(
                //   child: Assets.svgs.shapes.bottomNavigationShape.svg(),
                // ),
                Positioned(
                  height: 62.h,
                  bottom: 28.h,
                  left: 16.w,
                  right: 16.w,
                  child: Obx(
                    () {
                      final sessionService = Get.find<SessionService>();
                      final isCustomer = sessionService.currentUser.value?.customerType == 'customer';

                      return Row(
                        spacing: 12.75.w,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBottomNavigationBarItem(
                            onTap: () => controller.currentIndex.value = 0,
                            label: 'BCOOM',
                            icon: Assets.svgs.icons.home.svg(
                              colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            activeIcon: Assets.svgs.icons.homeActive.svg(
                              colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            isActive: controller.currentIndex.value == 0,
                          ),
                          _buildBottomNavigationBarItem(
                            onTap: () => controller.currentIndex.value = 1,
                            label: 'Sản phẩm',
                            icon: Assets.svgs.icons.menu.svg(
                              colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            activeIcon: Assets.svgs.icons.menuActive.svg(
                              colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            isActive: controller.currentIndex.value == 1,
                          ),
                          // _buildFabButton(),
                          _buildBottomNavigationBarItem(
                            onTap: () => controller.currentIndex.value = 2,
                            label: isCustomer ? 'Đơn hàng' : 'Doanh số',
                            icon: isCustomer
                                ? Icon(
                                    Symbols.receipt_long,
                                    size: 20.h,
                                    color: AppColors.text500,
                                  )
                                : Assets.svgs.icons.chart.svg(
                                    colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn),
                                    width: 20.h,
                                    height: 20.h,
                                  ),
                            activeIcon: isCustomer
                                ? Icon(
                                    Symbols.receipt_long,
                                    size: 20.h,
                                    color: AppColors.primaryColor,
                                  )
                                : Assets.svgs.icons.chartActive.svg(
                                    colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                    width: 20.h,
                                    height: 20.h,
                                  ),
                            isActive: controller.currentIndex.value == 2,
                          ),
                          _buildBottomNavigationBarItem(
                            onTap: () => controller.currentIndex.value = 3,
                            label: 'Tài khoản',
                            icon: Assets.svgs.icons.profile.svg(
                              colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            activeIcon: Assets.svgs.icons.profileActive.svg(
                              colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                              width: 20.h,
                              height: 20.h,
                            ),
                            isActive: controller.currentIndex.value == 3,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBarItem({
    required VoidCallback onTap,
    required String label,
    required Widget icon,
    required Widget activeIcon,
    required bool isActive,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        // borderRadius: BorderRadius.circular(100.r),
        child: Column(
          spacing: 4.h,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isActive ? activeIcon : icon,
            Text(
              label,
              style: AppTextStyles.body12.copyWith(color: isActive ? AppColors.primaryColor : AppColors.text500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFabButton() {
    return SizedBox(
      width: 54.h,
      height: 54.h,
      child: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        shape: CircleBorder(side: BorderSide(color: AppColors.primaryColor, width: 2.w)),
        child: Icon(Icons.add, size: 24.sp, color: Colors.white),
      ),
    );
  }
}

class _HomePage extends GetView<HomeController> {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100.w,
        leading: Center(
          child: Assets.logos.horizontalLogo.svg(
            height: 40,
            fit: BoxFit.fitHeight,
          ),
        ),
        actions: [
          AppIconButton(
            onPressed: () {},
            icon: Assets.svgs.icons.notification.svg(),
          ),
          SizedBox(width: 16.w),
          AppIconButton(
            onPressed: () {
              AppPageNames.navigateToWishlist();
            },
            icon: Assets.svgs.icons.heart.svg(),
          ),
          SizedBox(width: 16.w),
          AppIconButton(
            onPressed: () {
              Get.toNamed('/cart');
            },
            icon: Assets.svgs.icons.shoppingCart.svg(),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.rawLandingPage.value == null) {
          return const Center(child: Text('Không có dữ liệu'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchAllData();
            return Future.value();
          },
          child: _buildLandingPageByRawData(),
        );
      }),
    );
  }

  Widget _buildLandingPageByRawData() {
    return Obx(
      () {
        List<MapEntry<String, dynamic>> elements = controller.rawLandingPage.value?.entries.toList() ?? [];

        elements.sort((a, b) {
          final aOrder = (a.value is Map && a.value['ordering'] != null) ? a.value['ordering'] as int : 0;
          final bOrder = (b.value is Map && b.value['ordering'] != null) ? b.value['ordering'] as int : 0;
          return aOrder.compareTo(bOrder);
        });

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20.h,
            children: List.generate(
              elements.length,
              (index) => Builder(builder: (context) {
                switch (elements[index].value['home_position_type_key']) {
                  case 'home_banners':
                    return HomeElementHomeBanners(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'top_deal':
                    return HomeElementTopDeal(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'flash_deal':
                    return HomeElementFlashDeal(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'brand':
                    return HomeElementBrand(
                      key: ValueKey<String>(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'luxury':
                    return HomeElementLuxury(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'sales_community':
                    return HomeElementCommunity(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'sales_academy':
                    return HomeElementAcademy(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  case 'product':
                    return HomeElementProduct(
                      key: Key(elements[index].key),
                      data: elements[index].value,
                    );
                  default:
                    return SizedBox.shrink();
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
