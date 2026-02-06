import 'dart:convert';

import 'package:logger/web.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import 'section_background.dart';
import 'section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../domain/usecases/get_home_product_usecase.dart';
import '../controllers/home_product_controller.dart';

Map<String, dynamic> parseKeywords(dynamic raw) {
  if (raw == null) return {};

  // If backend ever fixes it and returns Map directly
  if (raw is Map<String, dynamic>) return raw;

  if (raw is String) {
    final decoded = jsonDecode(raw);
    return {
      'product_sort': decoded['product_sort'],
      'product_ids': (decoded['product_ids'] as List?)?.map((e) => int.parse(e.toString()).toString()).toList(),
    };
  }

  return {};
}

class HomeElementTopDeal extends StatefulWidget {
  const HomeElementTopDeal({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<HomeElementTopDeal> createState() => _HomeElementTopDealState();
}

class _HomeElementTopDealState extends State<HomeElementTopDeal> {
  late final HomeProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HomeProductController(getHomeProductUseCase: Get.find<GetHomeProductUseCase>()),
      tag: (widget.key as ValueKey<String>).value,
    );

    _controller.getHomeProduct(
      keywords: widget.data['keywords'].toString(),
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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Row(
                    spacing: 16.w,
                    children: List.generate(_controller.homeProduct.value?['rows']?.length ?? 0, (index) {
                      var width = (Get.width - (16.w * (2 + 1))) / 2;
                      var scale = width / 286;
                      var product = _controller.homeProduct.value?['rows'][index];
                      var marketPrice = num.tryParse(product['price_market'].toString()) ?? 0;
                      var salePrice = num.tryParse(product['price_sale'].toString()) ?? 0;
                      return GestureDetector(
                        onTap: () {
                          AppPageNames.navigateToProductDetail(nameSlug: product['name_slug']);
                        },
                        child: SizedBox(
                          width: width,
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 286 / 502,
                                child: Column(
                                  spacing: 8.h,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(scale * 143),
                                            topRight: Radius.circular(scale * 32),
                                            bottomRight: Radius.circular(scale * 143),
                                            bottomLeft: Radius.circular(scale * 20),
                                          ),
                                        ),
                                        child: SectionBackground(
                                          imageUrl: product['image_url'],
                                          imageLocation: product['image_location'],
                                          usePositioned: false,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      spacing: 8.h,
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
                                                text: CurrencyUtils.formatVNDWithoutSymbol(product['price_sale']),
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
                                              if (product['price_market'] != null)
                                                TextSpan(
                                                  text: "${CurrencyUtils.formatVNDWithoutSymbol(product['price_market'])}đ",
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (salePrice < marketPrice)
                                Positioned(
                                  top: (16 * scale).h,
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
