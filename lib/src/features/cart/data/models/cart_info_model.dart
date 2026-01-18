import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/cart_info_entity.dart';

class CartInfoModel extends CartInfoEntity {
  CartInfoModel({
    required super.sources,
    required super.count,
    required super.totalProduct,
    required super.products,
    required super.remarks,
    required super.vouchers,
    required super.voucherCode,
    required super.voucherDiscount,
    required super.voucherDiscountPlatform,
    required super.voucherDiscountSeller,
    required super.voucherMessage,
    required super.shippingFee,
    required super.surcharge,
    required super.total,
    required super.addressId,
    required super.distance,
    super.shippingAddress,
  });

  factory CartInfoModel.fromJson(Map<String, dynamic> json) {
    return CartInfoModel(
      sources: JsonMapperUtils.safeParseString(json['sources']),
      count: JsonMapperUtils.safeParseInt(json['count']),
      totalProduct: JsonMapperUtils.safeParseDouble(json['total_product']),
      products: JsonMapperUtils.safeParseList(
        json['products'],
        mapper: (e) => CartProductModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      remarks: JsonMapperUtils.safeParseString(json['remarks']),
      vouchers: json['vouchers'] as List<dynamic>? ?? [],
      voucherCode: JsonMapperUtils.safeParseString(json['voucher_code']),
      voucherDiscount: JsonMapperUtils.safeParseDouble(json['voucher_discount']),
      voucherDiscountPlatform: JsonMapperUtils.safeParseDouble(json['voucher_discount_platform'] ?? 0),
      voucherDiscountSeller: JsonMapperUtils.safeParseDouble(json['voucher_discount_seller'] ?? 0),
      voucherMessage: JsonMapperUtils.safeParseString(json['voucher_message']),
      shippingFee: JsonMapperUtils.safeParseDouble(json['shipping_fee']),
      surcharge: JsonMapperUtils.safeParseDouble(json['surcharge']),
      total: JsonMapperUtils.safeParseDouble(json['total']),
      addressId: JsonMapperUtils.safeParseInt(json['address_id']),
      distance: JsonMapperUtils.safeParseDouble(json['distance']),
      shippingAddress: json['shipping_address'] != null
          ? CartShippingAddressModel.fromJson(
              JsonMapperUtils.safeParseMap(json['shipping_address']),
            )
          : null,
    );
  }
}

class CartProductModel extends CartProductEntity {
  CartProductModel({
    required super.id,
    required super.name,
    required super.code,
    required super.sku,
    required super.priceBase,
    required super.priceSale,
    super.categoryId,
    super.brandId,
    required super.imageUrl,
    required super.sellerId,
    required super.sellerName,
    required super.productSlug,
    required super.sellerSlug,
    required super.variants,
    required super.variantId,
    required super.quantity,
    super.variantName,
    super.variantSku,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      code: JsonMapperUtils.safeParseString(json['code']),
      sku: JsonMapperUtils.safeParseString(json['sku']),
      priceBase: JsonMapperUtils.safeParseDouble(json['price_base']),
      priceSale: JsonMapperUtils.safeParseDouble(json['price_sale']),
      categoryId: JsonMapperUtils.safeParseStringNullable(json['category_id']),
      brandId: JsonMapperUtils.safeParseIntNullable(json['brand_id']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      sellerId: JsonMapperUtils.safeParseInt(json['seller_id']),
      sellerName: JsonMapperUtils.safeParseString(json['seller_name']),
      productSlug: JsonMapperUtils.safeParseString(json['product_slug']),
      sellerSlug: JsonMapperUtils.safeParseString(json['seller_slug']),
      variants: JsonMapperUtils.safeParseList(
        json['variants'],
        mapper: (e) => CartProductVariantModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      variantId: JsonMapperUtils.safeParseInt(json['variant_id']),
      quantity: JsonMapperUtils.safeParseInt(json['quantity']),
      variantName: JsonMapperUtils.safeParseStringNullable(json['variant_name']),
      variantSku: JsonMapperUtils.safeParseStringNullable(json['variant_sku']),
    );
  }
}

class CartProductVariantModel extends CartProductVariantEntity {
  CartProductVariantModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.priceBase,
    required super.priceSale,
    super.amountInventory,
    required super.masterProductId,
    required super.productImages,
  });

  factory CartProductVariantModel.fromJson(Map<String, dynamic> json) {
    return CartProductVariantModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      sku: JsonMapperUtils.safeParseString(json['sku']),
      priceBase: JsonMapperUtils.safeParseDouble(json['price_base']),
      priceSale: JsonMapperUtils.safeParseDouble(json['price_sale']),
      amountInventory: JsonMapperUtils.safeParseIntNullable(json['amount_inventory']),
      masterProductId: JsonMapperUtils.safeParseInt(json['master_product_id']),
      productImages: JsonMapperUtils.safeParseList(
        json['product_images'],
        mapper: (e) => CartProductImageModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class CartProductImageModel extends CartProductImageEntity {
  CartProductImageModel({
    required super.id,
    required super.productId,
    required super.imageUrl,
    required super.imageLocation,
  });

  factory CartProductImageModel.fromJson(Map<String, dynamic> json) {
    // Combine image_url and image_location if image_location is present
    final imageUrl = JsonMapperUtils.safeParseString(json['image_url']);
    final imageLocation = JsonMapperUtils.safeParseString(json['image_location']);
    
    String fullImageUrl = imageUrl;
    if (imageLocation.isNotEmpty) {
      // If image_url is a base URL (ends without path) and image_location is a path, combine them
      final baseUrl = imageUrl.endsWith('/') ? imageUrl.substring(0, imageUrl.length - 1) : imageUrl;
      final location = imageLocation.startsWith('/') ? imageLocation : '/$imageLocation';
      fullImageUrl = baseUrl + location;
    }

    return CartProductImageModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      productId: JsonMapperUtils.safeParseInt(json['product_id']),
      imageUrl: fullImageUrl,
      imageLocation: imageLocation,
    );
  }
}

class CartShippingAddressModel extends CartShippingAddressEntity {
  CartShippingAddressModel({
    required super.id,
    super.name,
    super.phone,
    super.street,
    super.note,
    super.ward,
    super.wardCode,
    super.district,
    super.province,
    super.provinceCode,
    super.latitude,
    super.longitude,
  });

  factory CartShippingAddressModel.fromJson(Map<String, dynamic> json) {
    // Handle province - can be object or string
    String? provinceName;
    String? provinceCode;
    if (json['province'] != null) {
      if (json['province'] is Map) {
        provinceName = JsonMapperUtils.safeParseStringNullable(json['province']['name']);
        provinceCode = JsonMapperUtils.safeParseStringNullable(json['province']['province_code']);
      } else {
        provinceName = JsonMapperUtils.safeParseStringNullable(json['province']);
      }
    }

    // Handle ward - can be object or string
    String? wardName;
    String? wardCode;
    if (json['ward'] != null) {
      if (json['ward'] is Map) {
        wardName = JsonMapperUtils.safeParseStringNullable(json['ward']['name']);
        wardCode = JsonMapperUtils.safeParseStringNullable(json['ward']['ward_code']);
      } else {
        wardName = JsonMapperUtils.safeParseStringNullable(json['ward']);
      }
    }

    return CartShippingAddressModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseStringNullable(json['name']),
      phone: JsonMapperUtils.safeParseStringNullable(json['phone']),
      street: JsonMapperUtils.safeParseStringNullable(json['street']),
      note: JsonMapperUtils.safeParseStringNullable(json['note']),
      ward: wardName,
      wardCode: wardCode,
      district: JsonMapperUtils.safeParseStringNullable(json['district']),
      province: provinceName,
      provinceCode: provinceCode,
      latitude: JsonMapperUtils.safeParseDoubleNullable(json['lat'] ?? json['latitude']),
      longitude: JsonMapperUtils.safeParseDoubleNullable(json['lng'] ?? json['longitude']),
    );
  }
}
