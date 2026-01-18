import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/wishlist_controller.dart';
import '../widgets/wishlist_product_card.dart';

class WishlistPage extends GetView<WishlistController> {
  static const String routeName = '/wishlist';

  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sản phẩm yêu thích'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Obx(() {
                  if (controller.wishlistProducts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: controller.refreshWishlist,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 16.h),
                        children: [
                          SizedBox(height: 120.h),
                          Center(
                            child: Text(
                              'Chưa có sản phẩm yêu thích',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.refreshWishlist,
                    child: MasonryGridView.count(
                      controller: controller.scrollController,
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.w, bottom: 80.h),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                      itemCount: controller.wishlistProducts.length + (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.wishlistProducts.length) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }

                        final product = controller.wishlistProducts[index];
                        return WishlistProductCard(product: product);
                      },
                    ),
                  );
                }),
        ),
      );
    });
  }
}
