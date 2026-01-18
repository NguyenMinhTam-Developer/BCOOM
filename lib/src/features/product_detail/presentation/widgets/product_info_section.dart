import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/product_detail_controller.dart';

/// Product information section including price, title, and info rows
class ProductInfoSection extends GetView<ProductDetailController> {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entity = controller.productDetailEntity.value;
      if (entity == null) {
        return const SizedBox.shrink();
      }

      final isFavorite = controller.isFavorite.value;

      // Format price
      String formatPrice(int price) {
        final priceString = price.toString();
        final buffer = StringBuffer();
        int count = 0;
        for (int i = priceString.length - 1; i >= 0; i--) {
          buffer.write(priceString[i]);
          count++;
          if (count % 3 == 0 && i != 0) {
            buffer.write('.');
          }
        }
        return '${buffer.toString().split('').reversed.join()}đ';
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price section with gradient background
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.primary100,
              border: Border(
                top: BorderSide(color: AppColors.bg400, width: 1),
                bottom: BorderSide(color: AppColors.bg400, width: 1),
              ),
            ),
            child: Text(
              formatPrice(entity.priceSale),
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),

          // Product title with favorite button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  spacing: 16.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        entity.name,
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.text500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.toggleFavorite,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isFavorite ? Symbols.favorite_rounded : Symbols.favorite_border_rounded,
                          color: isFavorite ? AppColors.primaryColor : AppColors.text200,
                          size: 24.w,
                          fill: isFavorite ? 1 : 0,
                        ),
                      ),
                    ),
                  ],
                ),
                // // Product link
                // _InfoRow.link(
                //   product.productLink,
                // ),

                // Category
                _InfoRow.normal(
                  label: "Danh mục",
                  value: entity.categoryName ?? '',
                ),

                // Brand with tag (Thương hiệu)
                _InfoRow.brand(
                  entity.brandName ?? '',
                ),

                // Supplier
                _InfoRow.normal(
                  label: "Nhà cung cấp",
                  value: entity.supplierName ?? '',
                ),

                // SKU
                _InfoRow.sku(
                  entity.sku,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

/// Reusable info row widget
class _InfoRow extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isLink;
  final bool isBrand;
  final bool isSku;
  final bool hasTrailingArrow;

  const _InfoRow._({
    this.label,
    this.value,
    this.isLink = false,
    this.isBrand = false,
    this.isSku = false,
    this.hasTrailingArrow = false,
  });

  factory _InfoRow.normal({required String label, required String value}) {
    return _InfoRow._(
      label: label,
      value: value,
      isLink: false,
      isBrand: false,
      hasTrailingArrow: true,
    );
  }

  factory _InfoRow.brand(String value) {
    return _InfoRow._(
      label: "Thương hiệu",
      value: value,
      isBrand: true,
      hasTrailingArrow: true,
    );
  }

  factory _InfoRow.sku(String value) {
    return _InfoRow._(
      label: "SKU",
      value: value,
      isSku: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var widget = Row(
      spacing: 12.w,
      children: [
        if (isLink == true) ...[
          Expanded(
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(text: "Link sản phẩm: ", style: AppTextStyles.body10.copyWith(color: AppColors.text500)),
                  TextSpan(text: value ?? "", style: AppTextStyles.body10.copyWith(color: AppColors.secondary500)),
                ],
              ),
            ),
          ),
          Card(
            color: AppColors.info100,
            shape: StadiumBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value ?? ""));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text("Sao chép", style: AppTextStyles.body12.copyWith(color: AppColors.info500)),
              ),
            ),
          ),
        ] else if (isBrand == true) ...[
          Text(
            'Thương hiệu',
            style: AppTextStyles.heading6.copyWith(color: AppColors.text300),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.error500,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              value ?? "",
              style: AppTextStyles.label12.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ] else if (isSku == true) ...[
          Text(
            'SKU',
            style: AppTextStyles.heading6.copyWith(color: AppColors.text300),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: AppTextStyles.body12.copyWith(
                color: AppColors.text200,
              ),
            ),
          ),
          Icon(
            Symbols.file_copy_rounded,
            color: AppColors.text500,
            size: 16.w,
          ),
        ] else ...[
          Text(
            label ?? "",
            style: AppTextStyles.heading6.copyWith(color: AppColors.text300),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: AppTextStyles.body12.copyWith(
                color: AppColors.text200,
              ),
            ),
          ),
        ],
        if (hasTrailingArrow == true) ...[
          Icon(
            Symbols.arrow_forward_ios_rounded,
            color: AppColors.text500,
            size: 16.w,
          ),
        ],
      ],
    );

    if (isLink == true) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.bg200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(4.r),
          ),
        ),
        child: widget,
      );
    }

    return widget;
  }
}
