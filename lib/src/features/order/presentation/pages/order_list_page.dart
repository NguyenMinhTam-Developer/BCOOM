import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_item_widget.dart';

class OrderListPage extends GetView<OrderController> {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Đơn hàng của tôi',
              style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
            ),
            elevation: 0,
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.orderStatusList.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Đơn hàng của tôi',
              style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
            ),
            elevation: 0,
          ),
          body: Center(
            child: Text(
              'Không có đơn hàng nào',
              style: AppTextStyles.body14.copyWith(color: AppColors.text300),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Đơn hàng của tôi',
            style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: Container(
              height: 48.h,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  spacing: 8.w,
                  children: List.generate(
                    controller.orderStatusList.length,
                    (index) {
                      final status = controller.orderStatusList[index];
                      final isSelected = controller.selectedTabIndex.value == index;

                      return GestureDetector(
                        onTap: () => controller.onTabTap(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary500 : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected ? AppColors.primary500 : AppColors.bg400,
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            status.name,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : AppColors.text400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoadingOrders.value && controller.currentOrdersList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.currentOrdersList.isEmpty) {
              return RefreshIndicator(
                onRefresh: controller.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64.w,
                          color: AppColors.text200,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Chưa có đơn hàng nào',
                          style: AppTextStyles.body14.copyWith(color: AppColors.text300),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refresh,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.h);
                },
                controller: controller.scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: controller.currentOrdersList.length + (controller.isLoadingMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.currentOrdersList.length) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }

                  final order = controller.currentOrdersList[index];
                  return OrderItemWidget(order: order);
                },
              ),
            );
          }),
        ),
      );
    });
  }
}
