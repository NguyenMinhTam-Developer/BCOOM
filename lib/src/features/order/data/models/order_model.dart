import '../../../../core/utils/json_mapper_utils.dart';
import '../../../search/data/models/pagination_model.dart';
import '../../domain/entities/order_entity.dart';

class OrderStatusModel extends OrderStatus {
  const OrderStatusModel({
    required super.name,
    required super.code,
    required super.numberOrders,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      name: JsonMapperUtils.safeParseString(json['name']),
      code: JsonMapperUtils.safeParseString(json['code']),
      numberOrders: JsonMapperUtils.safeParseInt(json['number_orders']),
    );
  }
}

class OrderPaymentModel extends OrderPayment {
  const OrderPaymentModel({
    required super.orderId,
    required super.method,
    required super.isPrepaid,
    super.description,
  });

  factory OrderPaymentModel.fromJson(Map<String, dynamic> json) {
    return OrderPaymentModel(
      orderId: JsonMapperUtils.safeParseInt(json['order_id']),
      method: JsonMapperUtils.safeParseString(json['method']),
      isPrepaid: JsonMapperUtils.safeParseInt(json['is_prepaid']),
      description: JsonMapperUtils.safeParseStringNullable(json['description']),
    );
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderCode,
    required super.paidPrice,
    required super.createdAt,
    required super.itemsCount,
    required super.statusCode,
    super.statusName,
    super.statusBackgroundColor,
    super.statusTextColor,
    required super.sellerId,
    required super.sellerName,
    required super.sellerPhone,
    super.sellerAddress,
    super.firstProductImage,
    super.firstProductName,
    super.firstProductSku,
    super.firstProductVariantId,
    super.firstProductVariantName,
    super.firstProductVariantSku,
    required super.payment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      orderCode: JsonMapperUtils.safeParseString(json['order_code']),
      paidPrice: JsonMapperUtils.safeParseInt(json['paid_price']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      itemsCount: JsonMapperUtils.safeParseInt(json['items_count']),
      statusCode: JsonMapperUtils.safeParseString(json['status_code']),
      statusName: JsonMapperUtils.safeParseStringNullable(json['status_name']),
      statusBackgroundColor: JsonMapperUtils.safeParseStringNullable(json['status_background_color']),
      statusTextColor: JsonMapperUtils.safeParseStringNullable(json['status_text_color']),
      sellerId: JsonMapperUtils.safeParseInt(json['seller_id']),
      sellerName: JsonMapperUtils.safeParseString(json['seller_name']),
      sellerPhone: JsonMapperUtils.safeParseString(json['seller_phone']),
      sellerAddress: JsonMapperUtils.safeParseStringNullable(json['seller_address']),
      firstProductImage: JsonMapperUtils.safeParseStringNullable(json['first_product_image']),
      firstProductName: JsonMapperUtils.safeParseStringNullable(json['first_product_name']),
      firstProductSku: JsonMapperUtils.safeParseStringNullable(json['first_product_sku']),
      firstProductVariantId: JsonMapperUtils.safeParseIntNullable(json['first_product_variant_id']),
      firstProductVariantName: JsonMapperUtils.safeParseStringNullable(json['first_product_variant_name']),
      firstProductVariantSku: JsonMapperUtils.safeParseStringNullable(json['first_product_variant_sku']),
      payment: OrderPaymentModel.fromJson(
        JsonMapperUtils.safeParseMap(json['payment']),
      ),
    );
  }
}

class PaginatedOrderListModel extends PaginatedOrderListEntity {
  const PaginatedOrderListModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory PaginatedOrderListModel.fromJson(Map<String, dynamic> json) {
    final limit = JsonMapperUtils.safeParseInt(json['limit']);
    final total = JsonMapperUtils.safeParseInt(json['total']);

    return PaginatedOrderListModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => OrderModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      pagination: PaginationModel.fromJson(
        JsonMapperUtils.safeParseMap(json['pagination']),
      ),
      limit: limit,
      total: total,
    );
  }
}
