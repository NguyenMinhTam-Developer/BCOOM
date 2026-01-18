import 'dart:convert';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import 'section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../domain/usecases/get_home_product_usecase.dart';
import '../controllers/home_product_controller.dart';
import 'section_background.dart';

class HomeElementFlashDeal extends StatefulWidget {
  const HomeElementFlashDeal({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<HomeElementFlashDeal> createState() => _HomeElementFlashDealState();
}

class _HomeElementFlashDealState extends State<HomeElementFlashDeal> {
  late final HomeProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HomeProductController(getHomeProductUseCase: Get.find<GetHomeProductUseCase>()),
      tag: (widget.key as ValueKey<String>).value,
    );

    Map<String, dynamic> keywords = jsonDecode(widget.data['keywords']);

    _controller.getHomeProduct(
      keywords: keywords,
    );
  }

  @override
  void dispose() {
    Get.delete<HomeProductController>(tag: (widget.key as ValueKey<String>).value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SectionBackground(
          imageUrl: widget.data['image_url'],
          imageLocation: widget.data['image_location'],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: [
              SectionTitle(
                rawTitle: widget.data['title']?.toString() ?? '',
                content: widget.data['content']?.toString() ?? '',
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Row(
                    spacing: 16.w,
                    children: List.generate(_controller.homeProduct.value?['rows']?.length ?? 0, (index) {
                      var width = (Get.width - (16.w * (2 + 1))) / 1.6;
                      var product = _controller.homeProduct.value?['rows'][index];
                      var marketPrice = num.tryParse(product['price_market'].toString()) ?? 0;
                      var salePrice = num.tryParse(product['price_sale'].toString()) ?? 0;
                      var commission = num.tryParse(product['price_commission'].toString()) ?? 0;
                      var numberOrdered = num.tryParse(product['number_ordered'].toString()) ?? 0;
                      var amountInventory = num.tryParse(product['amount_inventory'].toString()) ?? 0;

                      return GestureDetector(
                        onTap: () {
                          AppPageNames.navigateToProductDetail(nameSlug: product['name_slug']);
                        },
                        child: SizedBox(
                          width: width,
                          child: Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: AppColors.pink8, width: 1.w),
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 16.r,
                                      spreadRadius: 0,
                                      color: Colors.black.withValues(alpha: 0.1),
                                    ),
                                  ],
                                ),
                                child: AspectRatio(
                                    aspectRatio: 184 / 340,
                                    child: Stack(
                                      children: [
                                        Column(
                                          spacing: 14.h,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: SectionBackground(
                                                  imageUrl: product['image_url'],
                                                  imageLocation: product['image_location'],
                                                  usePositioned: false,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
                                                child: Column(
                                                  spacing: 4.h,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      "${product['name']?.toString() ?? ''}\n",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                        color: AppColors.ink1,
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Row(
                                                      spacing: 12.w,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Symbols.star_rounded,
                                                              color: Colors.amber,
                                                              size: 20.h,
                                                              fill: 1,
                                                            ),
                                                            SizedBox(width: 4.w),
                                                            Text(
                                                              num.tryParse(product['rate'].toString()) != null ? (product['rate'] as num).toStringAsFixed(1) : '0.0',
                                                              style: GoogleFonts.inter(
                                                                color: AppColors.ink1,
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width: 1.w,
                                                          height: 16.h,
                                                          color: AppColors.ink1,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              product['number_ordered']?.toString() ?? '0',
                                                              style: GoogleFonts.inter(
                                                                color: AppColors.ink1,
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            SizedBox(width: 4.w),
                                                            Text(
                                                              'Lượt Mua',
                                                              style: GoogleFonts.inter(
                                                                color: AppColors.ink1,
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "Hoa hồng ",
                                                            style: GoogleFonts.inter(
                                                              color: AppColors.ink1,
                                                              fontSize: 10.sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: CurrencyUtils.formatVNDWithoutSymbol(commission),
                                                            style: GoogleFonts.inter(
                                                              color: AppColors.secondaryPink,
                                                              fontSize: 10.sp,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: " / sản phẩm",
                                                            style: GoogleFonts.inter(
                                                              color: AppColors.ink1,
                                                              fontSize: 10.sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: salePrice == marketPrice
                                                            ? [
                                                                TextSpan(
                                                                  text: CurrencyUtils.formatVNDWithoutSymbol(salePrice),
                                                                  style: GoogleFonts.inter(
                                                                    color: AppColors.secondaryPink,
                                                                    fontSize: 18.sp,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  alignment: PlaceholderAlignment.top,
                                                                  child: Transform.translate(
                                                                    offset: Offset(0, -4),
                                                                    child: Text(
                                                                      'đ  ',
                                                                      style: GoogleFonts.inter(
                                                                        color: AppColors.secondaryPink,
                                                                        fontSize: 10.sp,
                                                                        fontWeight: FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                            : [
                                                                TextSpan(
                                                                  text: CurrencyUtils.formatVNDWithoutSymbol(salePrice),
                                                                  style: GoogleFonts.inter(
                                                                    color: AppColors.secondaryPink,
                                                                    fontSize: 18.sp,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  alignment: PlaceholderAlignment.top,
                                                                  child: Transform.translate(
                                                                    offset: Offset(0, -4),
                                                                    child: Text(
                                                                      'đ  ',
                                                                      style: GoogleFonts.inter(
                                                                        color: AppColors.secondaryPink,
                                                                        fontSize: 10.sp,
                                                                        fontWeight: FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: "${CurrencyUtils.formatVNDWithoutSymbol(marketPrice)}đ",
                                                                  style: GoogleFonts.inter(
                                                                    color: AppColors.ink1,
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w400,
                                                                    decoration: TextDecoration.lineThrough,
                                                                  ),
                                                                ),
                                                              ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 14.h,
                                                      clipBehavior: Clip.none,
                                                      padding: EdgeInsets.zero,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.pink9,
                                                        borderRadius: BorderRadius.circular(6.r),
                                                      ),
                                                      child: LayoutBuilder(builder: (context, constraints) {
                                                        var width = (numberOrdered > 0 && amountInventory > 0) ? (numberOrdered / amountInventory * constraints.maxWidth) : constraints.maxWidth;
                                                        var percentage = (numberOrdered > 0 && amountInventory > 0) ? (numberOrdered / amountInventory) : 1;
                                                        return Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Stack(
                                                            clipBehavior: Clip.none,
                                                            children: [
                                                              Container(
                                                                width: width,
                                                                height: constraints.maxHeight,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(6.r),
                                                                  gradient: LinearGradient(
                                                                    colors: [
                                                                      Color(0xFFFA4616),
                                                                      Color(0xFFE0004D),
                                                                      Color(0xFFFFFFFF).withAlpha(0),
                                                                    ],
                                                                    // The stop for the second color is based on percentage (capped at min 0.75)
                                                                    stops: [0, percentage.toDouble() < 0.75 ? 0.75 : percentage.toDouble(), 1],
                                                                    begin: Alignment.centerLeft,
                                                                    end: Alignment.centerRight,
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: -6.h,
                                                                left: width * (percentage.toDouble() < 0.75 ? 0.75 : percentage.toDouble()) - 12.w,
                                                                child: Assets.svgs.icons.hotDeal.svg(),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  "Đã bán ${numberOrdered.toStringAsFixed(0)}",
                                                                  style: GoogleFonts.inter(
                                                                    color: Colors.white,
                                                                    fontSize: 10.sp,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              if (salePrice < marketPrice)
                                Positioned(
                                  top: 16.h,
                                  child: _buildProductDiscountBadge(marketPrice, salePrice),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductDiscountBadge(num marketPrice, num salePrice) {
    num discountPercentage = (marketPrice - salePrice) / marketPrice * 100;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.red3,
      ),
      child: Text(
        "-${discountPercentage.toStringAsFixed(0)}%",
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
