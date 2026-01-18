class CartInfoEntity {
  final String sources;
  final int count;
  final num totalProduct;
  final List<CartProductEntity> products;
  final String remarks;
  final List<dynamic> vouchers;
  final String voucherCode;
  final num voucherDiscount;
  final num voucherDiscountPlatform;
  final num voucherDiscountSeller;
  final String voucherMessage;
  final num shippingFee;
  final num surcharge;
  final num total;
  final int addressId;
  final num distance;
  final CartShippingAddressEntity? shippingAddress;

  CartInfoEntity({
    required this.sources,
    required this.count,
    required this.totalProduct,
    required this.products,
    required this.remarks,
    required this.vouchers,
    required this.voucherCode,
    required this.voucherDiscount,
    required this.voucherDiscountPlatform,
    required this.voucherDiscountSeller,
    required this.voucherMessage,
    required this.shippingFee,
    required this.surcharge,
    required this.total,
    required this.addressId,
    required this.distance,
    this.shippingAddress,
  });
}

class CartProductEntity {
  final int id;
  final String name;
  final String code;
  final String sku;
  final num priceBase;
  final num priceSale;
  final String? categoryId;
  final int? brandId;
  final String imageUrl;
  final int sellerId;
  final String sellerName;
  final String productSlug;
  final String sellerSlug;
  final List<CartProductVariantEntity> variants;
  final int variantId;
  final int quantity;
  final String? variantName;
  final String? variantSku;

  CartProductEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.sku,
    required this.priceBase,
    required this.priceSale,
    this.categoryId,
    this.brandId,
    required this.imageUrl,
    required this.sellerId,
    required this.sellerName,
    required this.productSlug,
    required this.sellerSlug,
    required this.variants,
    required this.variantId,
    required this.quantity,
    this.variantName,
    this.variantSku,
  });
}

class CartProductVariantEntity {
  final int id;
  final String name;
  final String sku;
  final num priceBase;
  final num priceSale;
  final int? amountInventory;
  final int masterProductId;
  final List<CartProductImageEntity> productImages;

  CartProductVariantEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.priceBase,
    required this.priceSale,
    this.amountInventory,
    required this.masterProductId,
    required this.productImages,
  });
}

class CartProductImageEntity {
  final int id;
  final int productId;
  final String imageUrl;
  final String imageLocation;

  CartProductImageEntity({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.imageLocation,
  });
}

class CartShippingAddressEntity {
  final int id;
  final String? name;
  final String? phone;
  final String? street;
  final String? note;
  final String? ward;
  final String? wardCode;
  final String? district;
  final String? province;
  final String? provinceCode;
  final num? latitude;
  final num? longitude;

  CartShippingAddressEntity({
    required this.id,
    this.name,
    this.phone,
    this.street,
    this.note,
    this.ward,
    this.wardCode,
    this.district,
    this.province,
    this.provinceCode,
    this.latitude,
    this.longitude,
  });
}
