import 'product_image_entity.dart';
import 'product_variant_entity.dart';
import 'seller_entity.dart';
import 'brand_entity.dart';

class ProductDetailEntity {
  final int id;
  final String site;
  final int objectId;
  final int parentCategoryId;
  final String categoryId;
  final String? filterCategoryId;
  final int? masterProductId;
  final int? numberOrdered;
  final int? amountInventory;
  final String type;
  final double? rate;
  final String code;
  final String? barCode;
  final String name;
  final String? alias;
  final String? fullName;
  final int hasSubProduct;
  final String nameSlug;
  final int priceBase;
  final int priceSale;
  final int priceMarket;
  final String? price;
  final String? priceApplyTime;
  final int industryId;
  final int supplierId;
  final int? sellerId;
  final int brandId;
  final int unitId;
  final int? categoryFoodId;
  final String? subDescription;
  final String? description;
  final String? configurationInfo;
  final String? extras;
  final String imageUrl;
  final String imageLocation;
  final int weight;
  final int length;
  final int width;
  final int height;
  final int status;
  final int? statusId;
  final int? createdBy;
  final int? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sku;
  final String customerScope;
  final int? priceCommission;
  final String? sellerName;
  final String? brandName;
  final String? supplierName;
  final String? brandSlug;
  final String? categoryName;
  final List<ProductImageEntity> productImages;
  final List<ProductVariantEntity> variants;
  final SellerEntity? seller;
  final BrandEntity? brand;

  const ProductDetailEntity({
    required this.id,
    required this.site,
    required this.objectId,
    required this.parentCategoryId,
    required this.categoryId,
    required this.filterCategoryId,
    required this.masterProductId,
    required this.numberOrdered,
    required this.amountInventory,
    required this.type,
    required this.rate,
    required this.code,
    required this.barCode,
    required this.name,
    required this.alias,
    required this.fullName,
    required this.hasSubProduct,
    required this.nameSlug,
    required this.priceBase,
    required this.priceSale,
    required this.priceMarket,
    required this.price,
    required this.priceApplyTime,
    required this.industryId,
    required this.supplierId,
    required this.sellerId,
    required this.brandId,
    required this.unitId,
    required this.categoryFoodId,
    required this.subDescription,
    required this.description,
    required this.configurationInfo,
    required this.extras,
    required this.imageUrl,
    required this.imageLocation,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.status,
    required this.statusId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.sku,
    required this.customerScope,
    required this.priceCommission,
    required this.sellerName,
    required this.brandName,
    required this.supplierName,
    required this.brandSlug,
    required this.categoryName,
    required this.productImages,
    required this.variants,
    required this.seller,
    required this.brand,
  });
}

