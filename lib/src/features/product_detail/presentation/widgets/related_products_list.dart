import '../../../../core/routers/app_page_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../home/presentation/widgets/product_card.dart';
import '../../../search/domain/entities/search_product_entity.dart';
import '../controllers/product_detail_controller.dart';

/// Related products list that switches content based on selected second tab
class RelatedProductsList extends GetView<ProductDetailController> {
  const RelatedProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final relatedProducts = controller.relatedProducts.value;
      final selectedIndex = controller.selectedSecondTabIndex.value;

      if (relatedProducts == null) {
        return const SizedBox.shrink();
      }

      List<SearchProductEntity> products;

      switch (selectedIndex) {
        case 0: // Sản phẩm cùng thương hiệu
          products = relatedProducts.brand.rows;
          break;
        case 1: // Sản phẩm cùng danh mục
          products = relatedProducts.category.rows;
          break;
        case 2: // Sản phẩm cùng nhà bán lẻ
          products = relatedProducts.seller.rows;
          break;
        default:
          products = [];
      }

      if (products.isEmpty) {
        return const SizedBox.shrink();
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          spacing: 16.w,
          children: List.generate(products.length, (index) {
            final product = products[index];
            var width = (Get.width - (16.w * (2 + 1))) / 1.6;

            return GestureDetector(
              onTap: () => AppPageNames.navigateToProductDetail(
                nameSlug: product.nameSlug,
              ),
              child: SizedBox(
                width: width,
                child: ProductCard(
                  product: _convertEntityToMap(product),
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  /// Convert SearchProductEntity to Map format expected by ProductCard
  Map<String, dynamic> _convertEntityToMap(SearchProductEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'price_market': entity.priceMarket,
      'price_sale': entity.priceSale,
      'price_commission': entity.priceCommission,
      'image_url': entity.imageUrl,
      'image_location': entity.imageLocation,
      'name_slug': entity.nameSlug,
      'rate': entity.rate,
      'brand_name': entity.brandName,
      'seller_name': entity.sellerName,
    };
  }
}
