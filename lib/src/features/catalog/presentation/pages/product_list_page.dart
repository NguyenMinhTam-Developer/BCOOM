import 'package:bcoom/generated/assets.gen.dart';
import 'package:bcoom/src/core/routers/app_page_names.dart';
import 'package:bcoom/src/core/theme/app_colors.dart';
import 'package:bcoom/src/features/catalog/presentation/controllers/catalog_controller.dart';
import 'package:bcoom/src/features/catalog/presentation/widgets/filter_bottom_sheet.dart';
import 'package:bcoom/src/features/search/domain/entities/search_product_entity.dart';
import 'package:bcoom/src/shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_utils.dart';
import '../../../home/presentation/widgets/section_background.dart';
import '../controllers/product_list_controller.dart';

class ProductListPage extends GetView<ProductListController> {
  static const String routeName = '/products';

  static void navigateTo({required String slug, required String collectionSlug}) {
    Get.toNamed(routeName, parameters: {'slug': slug, 'collection_slug': collectionSlug});
  }

  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var appBarTitle = Get.find<CatalogController>().selectedMainCategory.value?.name ?? '';
      var appBarSubTitle = controller.subSideBarData.value?.category.name ?? '';

      Widget appBar = ListTile(
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(appBarTitle, style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        subtitle: Text(appBarSubTitle, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400)),
      );

      List<Widget> appBarActions = [
        AppIconButton(
          onPressed: () {
            if (controller.subSideBarData.value != null) {
              Get.bottomSheet(
                FilterBottomsheet(
                  selectedSubCategory: controller.subSideBarData.value!,
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                ),
              );
            }
          },
          icon: Assets.svgs.icons.filter.svg(),
        ),
        SizedBox(width: 16.w),
      ];

      if (controller.isLoading.value) {
        return Scaffold(
          appBar: AppBar(
            title: appBar,
            actions: appBarActions,
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      return DefaultTabController(
        length: controller.collections.value?.rows.length ?? 0,
        child: Scaffold(
          appBar: AppBar(
            title: appBar,
            backgroundColor: Colors.white,
            actions: appBarActions,
            bottom: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                onTap: controller.onTabTap,
                tabs: controller.collections.value?.rows
                        .map(
                          (e) => Tab(text: e.name),
                        )
                        .toList() ??
                    []),
          ),
          body: SafeArea(
            child: Obx(() {
              if (controller.isLoadingProducts.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return MasonryGridView.count(
                controller: controller.scrollController,
                clipBehavior: Clip.none,
                padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.w, bottom: 80.h),
                crossAxisCount: 2,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.w,
                itemCount: controller.productList.length + (controller.isLoadingMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show loading indicator at the bottom
                  if (index == controller.productList.length) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }

                  var product = controller.productList[index];
                  return FinalProductCard(
                    product: product,
                  );
                },
              );
            }),
          ),
        ),
      );
    });
  }
}

class FinalProductCard extends StatelessWidget {
  const FinalProductCard({
    super.key,
    required this.product,
  });

  final SearchProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppPageNames.navigateToProductDetail(nameSlug: product.nameSlug);
      },
      child: Container(
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
                    children: FinalProductLabel.values.map((e) => FinalProductLabel.getWidget(e)).toList(),
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
                            color: Color(0xFFFFC800),
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
                          "${CurrencyUtils.formatVNDWithoutSymbol(product.numberOrdered)} Lượt Mua",
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
                          text: CurrencyUtils.formatVNDWithoutSymbol(product.priceCommission),
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
                    children: FinalProductPromotion.values
                        .map(
                          (e) => FinalProductPromotion.getWidget(
                            e,
                            e == FinalProductPromotion.gift
                                ? 'Mua 1 tặng 1'
                                : e == FinalProductPromotion.discount
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

enum FinalProductLabel {
  bmall,
  highInterest,
  freeShip,
  newProduct,
  loveProduct,
  topDeal,
  genuineProduct,
  thirtyDaysReturnPolicy;

  Widget? get icon => switch (this) {
        FinalProductLabel.bmall => Assets.logos.bmallLogo.svg(),
        FinalProductLabel.highInterest => Assets.svgs.icons.highValue.svg(),
        FinalProductLabel.freeShip => Assets.svgs.icons.freeShip.svg(),
        FinalProductLabel.newProduct => null,
        FinalProductLabel.loveProduct => Assets.svgs.icons.like.svg(),
        FinalProductLabel.topDeal => Assets.svgs.icons.topDeal.svg(),
        FinalProductLabel.genuineProduct => Assets.svgs.icons.genuine.svg(),
        FinalProductLabel.thirtyDaysReturnPolicy => Assets.svgs.icons.returnPolicy.svg(),
      };

  String get label => switch (this) {
        FinalProductLabel.bmall => 'Bmall',
        FinalProductLabel.highInterest => 'Lãi cao',
        FinalProductLabel.freeShip => 'Freeship',
        FinalProductLabel.newProduct => 'NEW',
        FinalProductLabel.loveProduct => 'Yêu thích',
        FinalProductLabel.topDeal => 'Top Deal',
        FinalProductLabel.genuineProduct => 'Chính hãng',
        FinalProductLabel.thirtyDaysReturnPolicy => '30 ngày đổi trả',
      };

  Color get color => switch (this) {
        FinalProductLabel.bmall => Colors.transparent,
        FinalProductLabel.highInterest => Color(0xFFFFB129),
        FinalProductLabel.freeShip => Color(0xFF00BFA9),
        FinalProductLabel.newProduct => Color(0xFFE0004D),
        FinalProductLabel.loveProduct => Color(0xFFFF387D),
        FinalProductLabel.topDeal => Color(0xFFFA4616),
        FinalProductLabel.genuineProduct => Color(0xFF0044FF),
        FinalProductLabel.thirtyDaysReturnPolicy => Color(0xFF926AFF),
      };

  static Widget getWidget(FinalProductLabel label) {
    return Container(
      height: 14.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: label == FinalProductLabel.bmall ? null : label.color,
        borderRadius: BorderRadius.circular(2.r),
        gradient: label == FinalProductLabel.bmall
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

enum FinalProductPromotion {
  gift,
  discount,
  flashSale;

  Color get color => switch (this) {
        FinalProductPromotion.gift => Color(0xFFFF9500),
        FinalProductPromotion.discount => Color(0xFF0E9C22),
        FinalProductPromotion.flashSale => Color(0xFFF93C36),
      };

  static Widget getWidget(FinalProductPromotion promotion, String label) {
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
