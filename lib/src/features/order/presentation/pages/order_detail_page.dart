import 'package:bcoom/generated/assets.gen.dart';
import 'package:bcoom/src/shared/components/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/order_detail_controller.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
  const OrderDetailPage({super.key});

  static void navigateTo({required int orderId}) {
    Get.toNamed('/orders/$orderId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final orderDetail = controller.orderDetail.value;
        if (orderDetail == null) {
          return Center(
            child: Text(
              'Không tìm thấy đơn hàng',
              style: AppTextStyles.body14.copyWith(color: AppColors.text300),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: SafeArea(
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Order Status Timeline
                _buildStatusTimeline(orderDetail),
                // Information Cards
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12.h,
                  children: [
                    // Recipient Information
                    _buildRecipientInfoCard(orderDetail),
                    // Delivery Information
                    _buildDeliveryInfoCard(orderDetail),
                    // Payment Method & Invoice
                    _buildPaymentMethodCard(orderDetail),
                  ],
                ),
                // Product Information (grouped by seller)
                _buildProductInfoSection(orderDetail),
                // Order Summary
                _buildOrderSummaryCard(orderDetail),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.text500),
        onPressed: () => Get.back(),
      ),
      title: Obx(() {
        final orderDetail = controller.orderDetail.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chi tiết đơn hàng',
              style: AppTextStyles.heading4.copyWith(color: AppColors.text500),
            ),
            Text(
              orderDetail?.orderCode ?? '',
              style: AppTextStyles.body12.copyWith(color: AppColors.text300),
            ),
          ],
        );
      }),
      elevation: 0,
    );
  }

  Widget _buildStatusTimeline(orderDetail) {
    // Determine current status step
    int currentStep = _getStatusStep(orderDetail.statusCode);

    final steps = [
      {
        'label': 'Đã đặt hàng',
        'date': orderDetail.createdAt,
        'completed': currentStep >= 0,
      },
      {
        'label': 'Đang xử lý',
        'completed': currentStep >= 1,
      },
      {
        'label': 'Đang giao hàng',
        'completed': currentStep >= 2,
      },
      {
        'label': 'Giao hàng thành công',
        'completed': currentStep >= 3,
      },
    ];

    return AppCard(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: steps.map((step) {
          final isCompleted = step['completed'] as bool;
          final index = steps.indexOf(step);

          return Row(
            spacing: 12.w,
            children: [
              SizedBox(
                width: 32.w,
                height: 32.w,
                child: Builder(
                  builder: (context) {
                    if (isCompleted) {
                      return Icon(
                        Symbols.check_circle_filled_rounded,
                        size: 32.w,
                        color: Color(0xFF31CCBB),
                        fill: 1,
                      );
                    }
                    return Icon(
                      Symbols.radio_button_checked_rounded,
                      size: 32.w,
                      color: AppColors.ink6,
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  // spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      step['label'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink1,
                      ),
                    ),
                    if (step['date'] != null)
                      Text(
                        _formatDateTime(step['date'] as DateTime),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.ink3,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  int _getStatusStep(String statusCode) {
    switch (statusCode) {
      case 'waiting':
      case 'order_success':
        return 1; // Đang xử lý
      case 'ready_for_pickup':
      case 'delivering':
        return 2; // Đang giao hàng
      case 'completed':
        return 3; // Giao hàng thành công
      default:
        return 0; // Đã đặt hàng
    }
  }

  Widget _buildRecipientInfoCard(orderDetail) {
    final shippingAddress = orderDetail.shippingAddress;
    if (shippingAddress == null) return SizedBox.shrink();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: [
          Text(
            'Thông tin người nhận',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.text500,
            ),
          ),
          Text(
            '${shippingAddress.name} | ${shippingAddress.phone}',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text500,
            ),
          ),
          Text(
            shippingAddress.street,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfoCard(orderDetail) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: [
          Text(
            'Thông tin giao hàng',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.text500,
            ),
          ),
          Text(
            orderDetail.shippingFee > 0 ? 'Giao hàng tiêu chuẩn (${CurrencyUtils.formatVND(orderDetail.shippingFee)})' : 'Giao hàng tiêu chuẩn',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text500,
            ),
          ),
          Text(
            'Đơn vị vận chuyển: Bcoom Express',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text400,
            ),
          ),
          Text(
            'Thời gian giao hàng dự kiến: --',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(orderDetail) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: [
          Text(
            'Phương thức thanh toán',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.text500,
            ),
          ),
          Text(
            orderDetail.payment.method == 'cod' ? 'Thanh toán khi nhận hàng (COD)' : 'Thanh toán online',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Xuất hoá đơn',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.text500,
            ),
          ),
          Text(
            '---',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.text400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfoSection(orderDetail) {
    // Group items by seller (for now, all items are from the same seller)
    // In the future, this can be extended to handle suborders
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSellerGroup(
          sellerName: orderDetail.sellerName,
          items: orderDetail.items,
          orderDetail: orderDetail,
        ),
      ],
    );
  }

  Widget _buildSellerGroup({
    required String sellerName,
    required List items,
    required orderDetail,
  }) {
    final totalForSeller = items.fold<int>(
      0,
      (sum, item) => sum + ((item.paidPrice * item.quantity) as int),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.h,
        children: [
          // Store header
          Row(
            children: [
              Assets.icons.icStoreOutlined.svg(height: 16.w, width: 16.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  sellerName,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Symbols.local_shipping, size: 16.w, color: Colors.green),
              SizedBox(width: 8.w),
              Text(
                'Được giao bởi Viettel Post',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text400,
                ),
              ),
            ],
          ),
          Divider(height: 1.h, color: AppColors.bg400),
          // Products
          ...items.map((item) => _buildProductItem(item)),
          // Promotions placeholder (can be extended when API provides this data)
          // Store total
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền (${items.length} sản phẩm)',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text500,
                  ),
                ),
                Text(
                  CurrencyUtils.formatVND(totalForSeller),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.bg300,
              border: Border.all(color: AppColors.bg400, width: 1.w),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_outlined, size: 24.w, color: AppColors.text300);
                      },
                    )
                  : Icon(Icons.image_outlined, size: 24.w, color: AppColors.text300),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6.h,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.variant != null ? 'Phân loại: ${item.variant!.name}${item.variant!.sku != null ? ' - ${item.variant!.sku}' : ''}' : 'Phân loại: ${item.sku}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.text400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, size: 16.w, color: AppColors.text400),
                  ],
                ),
                Text(
                  'Số lượng: ${item.quantity}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.text400,
                  ),
                ),
                Text(
                  CurrencyUtils.formatVND(item.paidPrice),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(orderDetail) {
    final shippingDiscount = 0; // This would come from API if available

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: [
          _buildSummaryRow('Sản phẩm đã chọn', '${orderDetail.itemsCount}'),
          _buildSummaryRow('Tổng tiền', CurrencyUtils.formatVND(orderDetail.price)),
          if (orderDetail.shippingFee > 0) _buildSummaryRow('Phí vận chuyển', CurrencyUtils.formatVND(orderDetail.shippingFee)),
          if (shippingDiscount > 0) _buildSummaryRow('Giảm giá vận chuyển', '-${CurrencyUtils.formatVND(shippingDiscount)}', isDiscount: true),
          if (orderDetail.discount > 0) _buildSummaryRow('Giảm giá trực tiếp', '-${CurrencyUtils.formatVND(orderDetail.discount)}', isDiscount: true),
          if (orderDetail.discountSeller > 0) _buildSummaryRow('Ưu đãi từ shop', '-${CurrencyUtils.formatVND(orderDetail.discountSeller)}', isDiscount: true),
          if (orderDetail.discountPlatform > 0) _buildSummaryRow('Ưu đãi từ BCOOM', '-${CurrencyUtils.formatVND(orderDetail.discountPlatform)}', isDiscount: true),
          Divider(height: 1.h, color: AppColors.bg400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thanh toán',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text500,
                ),
              ),
              Text(
                CurrencyUtils.formatVND(orderDetail.paidPrice),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryPink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.text500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isDiscount ? AppColors.secondaryPink : AppColors.text500,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}, ${date.day}/${date.month}/${date.year}';
  }
}
