import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/product_detail_controller.dart';

/// First sticky tab bar delegate for SliverPersistentHeader
class ProductFirstStickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 48.h;

  @override
  double get maxExtent => 48.h;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const ProductFirstStickyTabBar();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

/// First sticky tab bar widget with 4 tabs
class ProductFirstStickyTabBar extends GetView<ProductDetailController> {
  const ProductFirstStickyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.bg400, width: 1),
        ),
      ),
      child: TabBar(
        controller: controller.firstTabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: AppColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        dividerColor: Colors.transparent,
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.text200,
        labelStyle: AppTextStyles.label12,
        unselectedLabelStyle: AppTextStyles.label12,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
        onTap: (index) {
          // Get the active ScrollController from the widget tree
          final scrollableState = Scrollable.maybeOf(context);
          final activeScrollController = scrollableState?.widget.controller;
          controller.selectFirstTab(index, activeScrollController: activeScrollController);
        },
        tabs: ProductDetailController.firstTabLabels
            .map((label) => Tab(text: label))
            .toList(),
      ),
    );
  }
}

