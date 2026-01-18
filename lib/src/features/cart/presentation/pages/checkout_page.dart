import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../controllers/cart_controller.dart';
import '../widgets/checkout_seller_group_section.dart';
import '../widgets/checkout_shipping_method_section.dart';
import '../widgets/checkout_payment_method_section.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final CartController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CartController>();
    // Load and select default address when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadAndSelectDefaultAddress();
    });
  }

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
        title: Text(
          'Thanh toán',
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.secondaryPink,
          ),
        ),
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
        if (cartInfo == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Symbols.shopping_cart_rounded,
                  size: 64.w,
                  color: AppColors.text200,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Giỏ hàng trống',
                  style: AppTextStyles.heading5.copyWith(
                    color: AppColors.text300,
                  ),
                ),
              ],
            ),
          );
        }

        // Get selected products only
        final selectedProducts = cartInfo.products
            .where((p) => controller.selectedProductIds.contains(p.id))
            .toList();

        if (selectedProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Symbols.shopping_cart_rounded,
                  size: 64.w,
                  color: AppColors.text200,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Vui lòng chọn sản phẩm để thanh toán',
                  style: AppTextStyles.heading5.copyWith(
                    color: AppColors.text300,
                  ),
                ),
              ],
            ),
          );
        }

        // Group selected products by seller
        final Map<int, List<CartProductEntity>> productsBySeller = {};
        for (var product in selectedProducts) {
          if (!productsBySeller.containsKey(product.sellerId)) {
            productsBySeller[product.sellerId] = [];
          }
          productsBySeller[product.sellerId]!.add(product);
        }

        // Calculate totals
        final selectedTotal = controller.getSelectedProductsTotal();
        final shippingFee = controller.selectedShippingMethod.value == 'express' ? 28000 : 16000;
        final total = selectedTotal + shippingFee - cartInfo.voucherDiscount;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Products grouped by seller
              ...productsBySeller.entries.map((entry) {
                final sellerProducts = entry.value;
                final sellerName = sellerProducts.first.sellerName;

                return Column(
                  children: [
                    CheckoutSellerGroupSection(
                      sellerId: entry.key,
                      sellerName: sellerName,
                      products: sellerProducts,
                    ),
                    SizedBox(height: 12.h),
                  ],
                );
              }),

              // Shipping Method Section
              const CheckoutShippingMethodSection(),
              SizedBox(height: 12.h),

              // Payment Method Section
              const CheckoutPaymentMethodSection(),
              SizedBox(height: 12.h),

              // Address Section
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Symbols.location_on_rounded,
                              size: 18.w,
                              color: AppColors.text500,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Giao tới',
                              style: AppTextStyles.heading5.copyWith(
                                color: AppColors.text500,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            final selectedAddressId = await AppPageNames.navigateToSelectShippingAddress();
                            if (selectedAddressId != null) {
                              // Address selection is handled in the select page
                              // Cart will be updated automatically
                            }
                          },
                          child: Text(
                            'Thay đổi',
                            style: AppTextStyles.body14.copyWith(
                              color: AppColors.secondaryPink,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (cartInfo.shippingAddress != null) ...[
                      Text(
                        cartInfo.shippingAddress!.name ?? '',
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.text500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        cartInfo.shippingAddress!.phone ?? '',
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.text500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _buildFullAddress(cartInfo.shippingAddress!),
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.text500,
                        ),
                      ),
                    ] else ...[
                      Text(
                        'Chưa có địa chỉ giao hàng',
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.text200,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Order Summary Section
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đơn hàng',
                      style: AppTextStyles.heading5.copyWith(
                        color: AppColors.text500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Divider(color: AppColors.ink6),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sản phẩm đã chọn',
                          style: AppTextStyles.body14.copyWith(
                            color: AppColors.text300,
                          ),
                        ),
                        Text(
                          '${selectedProducts.length}',
                          style: AppTextStyles.body14.copyWith(
                            color: AppColors.text500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Tổng tiền',
                      value: selectedTotal,
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Phí vận chuyển',
                      value: shippingFee,
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Giảm giá vận chuyển',
                      value: 0,
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Giảm giá trực tiếp',
                      value: 0,
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Ưu đãi từ shop',
                      value: 0,
                    ),
                    SizedBox(height: 8.h),
                    _SummaryRow(
                      label: 'Ưu đãi từ BCOOM',
                      value: cartInfo.voucherDiscount,
                      valueColor: AppColors.primaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Divider(color: AppColors.ink6),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng thanh toán',
                          style: AppTextStyles.heading5.copyWith(
                            color: AppColors.text500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              CurrencyUtils.formatVNDWithoutSymbol(total),
                              style: AppTextStyles.heading4.copyWith(
                                color: AppColors.secondaryPink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '₫',
                              style: AppTextStyles.body10.copyWith(
                                color: AppColors.secondaryPink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h), // Space for bottom button
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final cartInfo = controller.cartInfo.value;
        if (cartInfo == null) return const SizedBox.shrink();
        
        // Check if cart has no items
        if (cartInfo.products.isEmpty) return const SizedBox.shrink();

        final selectedProducts = cartInfo.products
            .where((p) => controller.selectedProductIds.contains(p.id))
            .toList();

        if (selectedProducts.isEmpty) return const SizedBox.shrink();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: GestureDetector(
                onTap: () {
                  if (cartInfo.shippingAddress == null) {
                    Get.snackbar(
                      'Lỗi',
                      'Vui lòng chọn địa chỉ giao hàng',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  // Submit order
                  controller.confirmPlacingOrder(
                    products: selectedProducts.map((p) => {
                      'id': p.id,
                      'quantity': p.quantity,
                    }).toList(),
                    remarks: cartInfo.remarks.isEmpty ? null : cartInfo.remarks,
                    paymentMethod: controller.selectedPaymentMethod.value,
                    shippingAddress: {
                      'name': cartInfo.shippingAddress!.name ?? '',
                      'phone': cartInfo.shippingAddress!.phone ?? '',
                      'street': cartInfo.shippingAddress!.street ?? '',
                      'province_code': cartInfo.shippingAddress!.provinceCode ?? '',
                      'district_id': cartInfo.shippingAddress!.wardCode ?? '',
                    },
                  );
                },
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryOrange,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Đặt hàng',
                      style: AppTextStyles.label14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String _buildFullAddress(CartShippingAddressEntity address) {
    final parts = <String>[];
    if (address.street != null && address.street!.isNotEmpty) {
      parts.add(address.street!);
    }
    if (address.ward != null && address.ward!.isNotEmpty) {
      parts.add(address.ward!);
    }
    if (address.district != null && address.district!.isNotEmpty) {
      parts.add(address.district!);
    }
    if (address.province != null && address.province!.isNotEmpty) {
      parts.add(address.province!);
    }
    return parts.isEmpty ? 'Chưa có' : parts.join(', ');
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final num value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value < 0 ? -value : value;
    final prefix = value < 0 ? '-' : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body14.copyWith(
            color: AppColors.text300,
          ),
        ),
        Row(
          children: [
            if (prefix.isNotEmpty)
              Text(
                prefix,
                style: AppTextStyles.body14.copyWith(
                  color: valueColor ?? AppColors.text500,
                ),
              ),
            Text(
              CurrencyUtils.formatVNDWithoutSymbol(displayValue),
              style: AppTextStyles.body14.copyWith(
                color: valueColor ?? AppColors.text500,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '₫',
              style: AppTextStyles.body10.copyWith(
                color: valueColor ?? AppColors.text500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
