import 'package:bcoom/generated/assets.gen.dart';
import 'package:bcoom/src/core/routers/app_page_names.dart';
import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:bcoom/src/core/utils/currency_utils.dart';
import 'package:bcoom/src/shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/order_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity order;

  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r), boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.01),
          offset: Offset(0, 0),
          blurRadius: 4.r,
          spreadRadius: 0,
        ),
      ]),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Assets.icons.icStoreOutlined.svg(height: 16.h, width: 16.h),
                        Expanded(
                          child: Text(
                            order.sellerName,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: order.getStatusBackgroundColor,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                    child: Text(
                      order.statusName ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: order.getStatusTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8.w,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mã đơn hàng:",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      order.orderCode,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF005EFF),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 1.h, thickness: 1.h, color: AppColors.ink6),
          Row(
            spacing: 8.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52.w,
                width: 52.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.ink6, width: 1.w),
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(order.firstProductImage ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: BoxDecoration(
                  border: Border.all(color: AppColors.ink6, width: 1.w),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // This is for promotion tag, or other tags like new, best seller, etc.
                    // Row(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 4.h,
                      children: [
                        Text(
                          order.firstProductName ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Phân loại: ${order.firstProductName ?? ''}",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.ink2,
                          ),
                        ),
                        // Text(
                        //   "Cùng ${order.itemsCount - 1} sản phẩm khác",
                        //   style: GoogleFonts.inter(
                        //     fontSize: 12.sp,
                        //     fontWeight: FontWeight.w300,
                        //     color: AppColors.ink2,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Tổng số tiền (${order.itemsCount} sản phẩm): ",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: CurrencyUtils.formatVND(order.paidPrice),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink1,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 8.w,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton.outline(
                label: "Xem chi tiết",
                size: ButtonSize.small,
                onPressed: () {
                  AppPageNames.navigateToOrderDetail(orderId: order.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
