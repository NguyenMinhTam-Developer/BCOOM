import 'dart:ui';

import 'order_entity.dart';

class ProductImageEntity {
  final int id;
  final int productId;
  final String imageUrl;
  final String imageLocation;

  const ProductImageEntity({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.imageLocation,
  });
}

class VariantEntity {
  final int id;
  final String? site;
  final int? objectId;
  final int? parentCategoryId;
  final String? categoryId;
  final String? filterCategoryId;
  final int? masterProductId;
  final int numberOrdered;
  final int amountInventory;
  final String? type;
  final double? rate;
  final String? code;
  final String? barCode;
  final String name;
  final String? alias;
  final String? fullName;
  final int hasSubProduct;
  final String? nameSlug;
  final int priceBase;
  final int priceSale;
  final int? priceMarket;
  final int? price;
  final String? priceApplyTime;
  final int? industryId;
  final int? supplierId;
  final int? brandId;
  final int? unitId;
  final int? categoryFoodId;
  final String? subDescription;
  final String? description;
  final String? configurationInfo;
  final String? extras;
  final String? imageUrl;
  final String? imageLocation;
  final int? weight;
  final int? length;
  final int? width;
  final int? height;
  final int status;
  final int? statusId;
  final int? createdBy;
  final int? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? sku;
  final String? customerScope;
  final List<ProductImageEntity> productImages;

  const VariantEntity({
    required this.id,
    this.site,
    this.objectId,
    this.parentCategoryId,
    this.categoryId,
    this.filterCategoryId,
    this.masterProductId,
    required this.numberOrdered,
    required this.amountInventory,
    this.type,
    this.rate,
    this.code,
    this.barCode,
    required this.name,
    this.alias,
    this.fullName,
    required this.hasSubProduct,
    this.nameSlug,
    required this.priceBase,
    required this.priceSale,
    this.priceMarket,
    this.price,
    this.priceApplyTime,
    this.industryId,
    this.supplierId,
    this.brandId,
    this.unitId,
    this.categoryFoodId,
    this.subDescription,
    this.description,
    this.configurationInfo,
    this.extras,
    this.imageUrl,
    this.imageLocation,
    this.weight,
    this.length,
    this.width,
    this.height,
    required this.status,
    this.statusId,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.sku,
    this.customerScope,
    required this.productImages,
  });
}

class OrderItemEntity {
  final int id;
  final int orderId;
  final int parentOrderId;
  final String sku;
  final int productId;
  final int variantId;
  final String name;
  final String? imageUrl;
  final String? detailUrl;
  final int itemPrice;
  final int paidPrice;
  final int quantity;
  final int shippingFee;
  final String voucherCode;
  final String? warehouseCode;
  final String status;
  final Map<String, dynamic>? extraAttributes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VariantEntity? variant;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.parentOrderId,
    required this.sku,
    required this.productId,
    required this.variantId,
    required this.name,
    this.imageUrl,
    this.detailUrl,
    required this.itemPrice,
    required this.paidPrice,
    required this.quantity,
    required this.shippingFee,
    required this.voucherCode,
    this.warehouseCode,
    required this.status,
    this.extraAttributes,
    required this.createdAt,
    required this.updatedAt,
    this.variant,
  });
}

class ShippingAddressEntity {
  final int id;
  final int orderId;
  final String name;
  final String phone;
  final String? email;
  final String street;
  final String? building;
  final String? gate;
  final int distance;
  final double? lat;
  final double? lng;

  const ShippingAddressEntity({
    required this.id,
    required this.orderId,
    required this.name,
    required this.phone,
    this.email,
    required this.street,
    this.building,
    this.gate,
    required this.distance,
    this.lat,
    this.lng,
  });
}

class OrderDetailEntity {
  final int id;
  final String orderCode;
  final DateTime createdAt;
  final int itemsCount;
  final int price;
  final String? voucherCode;
  final int discount;
  final int discountPlatform;
  final int discountSeller;
  final int shippingFee;
  final int surcharge;
  final int paidPrice;
  final String? remarks;
  final String statusCode;
  final String? type;
  final String? statusName;
  final String? statusBackgroundColor;
  final String? statusTextColor;
  final int sellerId;
  final String sellerName;
  final String sellerPhone;
  final String? sellerAddress;
  final OrderPayment payment;
  final ShippingAddressEntity? shippingAddress;
  final List<dynamic> suborders;
  final List<OrderItemEntity> items;

  const OrderDetailEntity({
    required this.id,
    required this.orderCode,
    required this.createdAt,
    required this.itemsCount,
    required this.price,
    this.voucherCode,
    required this.discount,
    required this.discountPlatform,
    required this.discountSeller,
    required this.shippingFee,
    required this.surcharge,
    required this.paidPrice,
    this.remarks,
    required this.statusCode,
    this.type,
    this.statusName,
    this.statusBackgroundColor,
    this.statusTextColor,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    this.sellerAddress,
    required this.payment,
    this.shippingAddress,
    required this.suborders,
    required this.items,
  });

  /// Helper function to convert a 6-character hex string (e.g., "00b3ca") to Color
  /// Handles strings with or without '#' prefix
  static Color? hexStringToColor(String? hexString) {
    if (hexString == null || hexString.isEmpty) return null;

    // Remove '#' if present
    String cleanedHex = hexString.replaceAll('#', '').trim();

    // Validate length (should be 6 characters for RGB)
    if (cleanedHex.length != 6) return null;

    try {
      // Add 'FF' prefix for full opacity (ARGB format: 0xAARRGGBB)
      String fullHex = 'FF$cleanedHex';
      int colorValue = int.parse(fullHex, radix: 16);
      return Color(colorValue);
    } catch (e) {
      // Return null if parsing fails
      return null;
    }
  }

  Color? get getStatusBackgroundColor {
    return hexStringToColor(statusBackgroundColor);
  }

  Color? get getStatusTextColor {
    return hexStringToColor(statusTextColor);
  }
}
