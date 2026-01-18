import '../../../../../generated/assets.gen.dart';
import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../home/presentation/widgets/section_background.dart';
import '../../../search/domain/entities/search_product_entity.dart';

class CatalogProductCard extends StatelessWidget {
  const CatalogProductCard({super.key, required this.product});

  final SearchProductEntity product;

  @override
  Widget build(BuildContext context) {
    var marketPrice = num.tryParse(product.priceMarket.toString()) ?? 0;
    var salePrice = num.tryParse(product.priceSale.toString()) ?? 0;
    var commission = num.tryParse(product.priceCommission.toString()) ?? 0;

    return GestureDetector(
      onTap: () {
        AppPageNames.navigateToProductDetail(nameSlug: product.nameSlug);
      },
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
                              imageUrl: product.imageUrl,
                              imageLocation: product.imageLocation,
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
                                Wrap(
                                  spacing: 4.w,
                                  runSpacing: 4.w,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.r),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFE10600),
                                            Color(0xFFE0004D),
                                            Color(0xFFFA4616),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4.w,
                                        children: [
                                          Assets.logos.bmallLogo.svg(),
                                          Text(
                                            "Bmall",
                                            style: GoogleFonts.inter(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.r),
                                        color: Color(0xFFFFB129),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4.w,
                                        children: [
                                          Assets.svgs.icons.highValue.svg(),
                                          Text(
                                            "Lãi cao",
                                            style: GoogleFonts.inter(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.r),
                                        color: Color(0xFF00BFA9),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4.w,
                                        children: [
                                          Assets.svgs.icons.freeShip.svg(),
                                          Text(
                                            "Freeship",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${product.name}\n",
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
                                          num.tryParse(product.rate.toString()) != null ? (product.rate as num).toStringAsFixed(1) : '0.0',
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
                                          product.numberOrdered.toString(),
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
