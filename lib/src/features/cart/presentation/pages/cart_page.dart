import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_select_all_section.dart';
import '../widgets/cart_seller_group_section.dart';
import '../widgets/cart_order_summary_section.dart';
import '../widgets/cart_bottom_bar.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.w,
            color: AppColors.text500,
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final cartInfo = controller.cartInfo.value;
          final productCount = cartInfo?.products.length ?? 0;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Giỏ hàng của bạn',
                style: AppTextStyles.heading4.copyWith(
                  color: AppColors.secondaryPink,
                ),
              ),
              if (productCount > 0)
                Text(
                  '(${productCount.toString().padLeft(2, '0')} sản phẩm)',
                  style: AppTextStyles.body12.copyWith(
                    color: AppColors.text300,
                  ),
                ),
            ],
          );
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        final cartInfo = controller.cartInfo.value;
        if (cartInfo == null || cartInfo.products.isEmpty) {
          return _buildEmptyCartState();
        }

        // Group products by seller
        final Map<int, List<CartProductEntity>> productsBySeller = {};
        for (var product in cartInfo.products) {
          if (!productsBySeller.containsKey(product.sellerId)) {
            productsBySeller[product.sellerId] = [];
          }
          productsBySeller[product.sellerId]!.add(product);
        }

        // Use responsive layout: row on larger screens, column on mobile
        final isWideScreen = MediaQuery.of(context).size.width > 600;

        if (isWideScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column - Products
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select All Section
                      const CartSelectAllSection(),
                      SizedBox(height: 12.h),

                      // Products grouped by seller
                      ...productsBySeller.entries.map((entry) {
                        final sellerProducts = entry.value;
                        final sellerName = sellerProducts.first.sellerName;

                        return Column(
                          children: [
                            CartSellerGroupSection(
                              sellerId: entry.key,
                              sellerName: sellerName,
                              products: sellerProducts,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      }),

                      SizedBox(height: 100.h), // Space for bottom bar
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Right column - Order Summary
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        final selectedTotal = controller.getSelectedProductsTotal();
                        final selectedCount = controller.getSelectedProductsCount();

                        return CartOrderSummarySection(
                          totalProducts: selectedTotal,
                          pointsUsed: 0,
                          shippingFee: cartInfo.shippingFee,
                          total: selectedTotal + cartInfo.shippingFee - cartInfo.voucherDiscount,
                          discount: cartInfo.voucherDiscount,
                          selectedCount: selectedCount,
                        );
                      }),
                      SizedBox(height: 100.h), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          // Mobile layout - stacked vertically
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Select All Section
                const CartSelectAllSection(),
                SizedBox(height: 12.h),

                // Products grouped by seller
                ...productsBySeller.entries.map((entry) {
                  final sellerProducts = entry.value;
                  final sellerName = sellerProducts.first.sellerName;

                  return Column(
                    children: [
                      CartSellerGroupSection(
                        sellerId: entry.key,
                        sellerName: sellerName,
                        products: sellerProducts,
                      ),
                      SizedBox(height: 12.h),
                    ],
                  );
                }),

                // Order Summary Section
                Obx(() {
                  final selectedTotal = controller.getSelectedProductsTotal();
                  final selectedCount = controller.getSelectedProductsCount();

                  return CartOrderSummarySection(
                    totalProducts: selectedTotal,
                    pointsUsed: 0,
                    shippingFee: cartInfo.shippingFee,
                    total: selectedTotal + cartInfo.shippingFee - cartInfo.voucherDiscount,
                    discount: cartInfo.voucherDiscount,
                    selectedCount: selectedCount,
                  );
                }),

                SizedBox(height: 100.h), // Space for bottom bar
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        final cartInfo = controller.cartInfo.value;
        if (cartInfo == null) return const SizedBox.shrink();

        // Check if cart has no items
        if (cartInfo.products.isEmpty) return const SizedBox.shrink();

        final selectedTotal = controller.getSelectedProductsTotal();
        final total = selectedTotal + cartInfo.shippingFee - cartInfo.voucherDiscount;

        return CartBottomBar(
          total: total,
          onPayment: () {
            if (controller.selectedProductIds.isEmpty) {
              Get.snackbar(
                'Lỗi',
                'Vui lòng chọn sản phẩm để thanh toán',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              return;
            }

            // Navigate to checkout page
            Get.toNamed(AppPageNames.checkout);
          },
        );
      }),
    );
  }

  Widget _buildEmptyCartState() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration Container
              SizedBox(
                width: 280.w,
                height: 280.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Decorative background elements
                    Positioned(
                      top: 20.h,
                      left: 0,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60.h,
                      right: 0,
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.h,
                      left: 20.w,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Main illustration
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Red X icon in circle
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Symbols.close_rounded,
                            size: 48.w,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Open box illustration (simplified)
                        Container(
                          width: 180.w,
                          height: 140.h,
                          child: Stack(
                            children: [
                              // Box base (brown/orange)
                              Positioned(
                                bottom: 0,
                                left: 20.w,
                                right: 20.w,
                                child: Container(
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4A574),
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 4.h),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB8E0F0), // Light blue interior
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                ),
                              ),
                              // Left flap (open)
                              Positioned(
                                top: 0,
                                left: 20.w,
                                child: Transform(
                                  alignment: Alignment.topLeft,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateX(-0.4),
                                  child: Container(
                                    width: 70.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4A574),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Right flap (open)
                              Positioned(
                                top: 0,
                                right: 20.w,
                                child: Transform(
                                  alignment: Alignment.topRight,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateX(-0.4),
                                  child: Container(
                                    width: 70.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC8965F),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48.h),

              // Text
              Text(
                'Lướt ONE5, lựa hàng ngay!',
                style: AppTextStyles.heading5.copyWith(
                  color: const Color(0xFF1E3A5F), // Dark blue
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
