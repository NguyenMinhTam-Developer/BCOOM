import 'package:bcoom/generated/assets.gen.dart';
import 'package:bcoom/src/core/routers/app_page_names.dart';
import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_utils.dart';
import '../../../home/presentation/widgets/section_background.dart';
import '../../domain/entities/viewed_product_entity.dart';

class ViewedProductCard extends StatelessWidget {
  const ViewedProductCard({
    super.key,
    required this.product,
  });

  final ViewedProductEntity product;

  String _formatViewedAt(DateTime? dt) {
    if (dt == null) return '';
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(dt.day)}/${two(dt.month)}/${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Viewed products API doesn't return `nameSlug`.
        // For now we try `code` as a best-effort placeholder.
        AppPageNames.navigateToProductDetail(nameSlug: product.code);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.pink8, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 16.r,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.w,
                    children: ViewedProductLabel.values.map((e) => ViewedProductLabel.getWidget(e)).toList(),
                  ),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink1,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: const Color(0xFFFFC800),
                            size: 18.sp,
                          ),
                          Text(
                            (product.rate ?? 5).toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.ink1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        height: 10.h,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        color: AppColors.ink1,
                      ),
                      Expanded(
                        child: Text(
                          'Đã xem: ${product.viewedNumber}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.ink1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (product.viewedAt != null)
                    Text(
                      'Xem gần nhất: ${_formatViewedAt(product.viewedAt)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text300,
                      ),
                    ),
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                          text: "--",
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: product.priceSale == product.priceMarket
                          ? [
                              TextSpan(
                                text: CurrencyUtils.formatVNDWithoutSymbol(product.priceSale),
                                style: GoogleFonts.inter(
                                  color: AppColors.secondaryPink,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                child: Transform.translate(
                                  offset: const Offset(0, -4),
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
                                text: CurrencyUtils.formatVNDWithoutSymbol(product.priceSale),
                                style: GoogleFonts.inter(
                                  color: AppColors.secondaryPink,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                child: Transform.translate(
                                  offset: const Offset(0, -4),
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
                                text: "${CurrencyUtils.formatVNDWithoutSymbol(product.priceMarket)}đ",
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
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.w,
                    children: ViewedProductPromotion.values
                        .map(
                          (e) => ViewedProductPromotion.getWidget(
                            e,
                            e == ViewedProductPromotion.gift
                                ? 'Mua 1 tặng 1'
                                : e == ViewedProductPromotion.discount
                                    ? 'Giảm thêm 8%'
                                    : 'Flash Sale 00:00 25/10',
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ViewedProductLabel {
  bmall,
  highInterest,
  freeShip,
  newProduct,
  loveProduct,
  topDeal,
  genuineProduct,
  thirtyDaysReturnPolicy;

  Widget? get icon => switch (this) {
        ViewedProductLabel.bmall => Assets.logos.bmallLogo.svg(),
        ViewedProductLabel.highInterest => Assets.svgs.icons.highValue.svg(),
        ViewedProductLabel.freeShip => Assets.svgs.icons.freeShip.svg(),
        ViewedProductLabel.newProduct => null,
        ViewedProductLabel.loveProduct => Assets.svgs.icons.like.svg(),
        ViewedProductLabel.topDeal => Assets.svgs.icons.topDeal.svg(),
        ViewedProductLabel.genuineProduct => Assets.svgs.icons.genuine.svg(),
        ViewedProductLabel.thirtyDaysReturnPolicy => Assets.svgs.icons.returnPolicy.svg(),
      };

  String get label => switch (this) {
        ViewedProductLabel.bmall => 'Bmall',
        ViewedProductLabel.highInterest => 'Lãi cao',
        ViewedProductLabel.freeShip => 'Freeship',
        ViewedProductLabel.newProduct => 'NEW',
        ViewedProductLabel.loveProduct => 'Yêu thích',
        ViewedProductLabel.topDeal => 'Top Deal',
        ViewedProductLabel.genuineProduct => 'Chính hãng',
        ViewedProductLabel.thirtyDaysReturnPolicy => '30 ngày đổi trả',
      };

  Color get color => switch (this) {
        ViewedProductLabel.bmall => Colors.transparent,
        ViewedProductLabel.highInterest => const Color(0xFFFFB129),
        ViewedProductLabel.freeShip => const Color(0xFF00BFA9),
        ViewedProductLabel.newProduct => const Color(0xFFE0004D),
        ViewedProductLabel.loveProduct => const Color(0xFFFF387D),
        ViewedProductLabel.topDeal => const Color(0xFFFA4616),
        ViewedProductLabel.genuineProduct => const Color(0xFF0044FF),
        ViewedProductLabel.thirtyDaysReturnPolicy => const Color(0xFF926AFF),
      };

  static Widget getWidget(ViewedProductLabel label) {
    return Container(
      height: 14.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: label == ViewedProductLabel.bmall ? null : label.color,
        borderRadius: BorderRadius.circular(2.r),
        gradient: label == ViewedProductLabel.bmall
            ? LinearGradient(
                colors: AppColors.primaryGradient.colors,
              )
            : null,
      ),
      child: Row(
        spacing: 4.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label.icon != null)
            SizedBox(
              height: 10.w,
              width: 10.w,
              child: label.icon!,
            ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              label.label,
              style: GoogleFonts.inter(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ViewedProductPromotion {
  gift,
  discount,
  flashSale;

  Color get color => switch (this) {
        ViewedProductPromotion.gift => const Color(0xFFFF9500),
        ViewedProductPromotion.discount => const Color(0xFF0E9C22),
        ViewedProductPromotion.flashSale => const Color(0xFFF93C36),
      };

  static Widget getWidget(ViewedProductPromotion promotion, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: promotion.color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}

