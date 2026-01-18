import 'dart:ui';

import '../../../search/domain/entities/pagination_entity.dart';

class OrderStatus {
  final String name;
  final String code;
  final int numberOrders;

  const OrderStatus({
    required this.name,
    required this.code,
    required this.numberOrders,
  });
}

class OrderPayment {
  final int orderId;
  final String method;
  final int isPrepaid;
  final String? description;

  const OrderPayment({
    required this.orderId,
    required this.method,
    required this.isPrepaid,
    this.description,
  });
}

class OrderEntity {
  final int id;
  final String orderCode;
  final int paidPrice;
  final DateTime createdAt;
  final int itemsCount;
  final String statusCode;
  final String? statusName;
  final String? statusBackgroundColor;
  final String? statusTextColor;
  final int sellerId;
  final String sellerName;
  final String sellerPhone;
  final String? sellerAddress;
  final String? firstProductImage;
  final String? firstProductName;
  final String? firstProductSku;
  final int? firstProductVariantId;
  final String? firstProductVariantName;
  final String? firstProductVariantSku;
  final OrderPayment payment;

  const OrderEntity({
    required this.id,
    required this.orderCode,
    required this.paidPrice,
    required this.createdAt,
    required this.itemsCount,
    required this.statusCode,
    this.statusName,
    this.statusBackgroundColor,
    this.statusTextColor,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    this.sellerAddress,
    this.firstProductImage,
    this.firstProductName,
    this.firstProductSku,
    this.firstProductVariantId,
    this.firstProductVariantName,
    this.firstProductVariantSku,
    required this.payment,
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

class PaginatedOrderListEntity {
  final List<OrderEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const PaginatedOrderListEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}
