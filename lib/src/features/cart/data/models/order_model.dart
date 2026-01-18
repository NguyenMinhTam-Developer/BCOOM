import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends CartOrderEntity {
  OrderModel({
    required super.parentOrderId,
    required super.sources,
    required super.statusCode,
    required super.price,
    required super.voucherCode,
    required super.discount,
    required super.shippingFee,
    required super.surcharge,
    required super.paidPrice,
    required super.itemsCount,
    super.remarks,
    required super.customerId,
    required super.sellerId,
    required super.hasExportEinvoice,
    required super.orderAt,
    required super.estimatedDeliveryDate,
    required super.type,
    required super.subOrderNumber,
    required super.updatedAt,
    required super.createdAt,
    required super.id,
    required super.orderCode,
    required super.paymentMethodName,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      parentOrderId: JsonMapperUtils.safeParseInt(json['parent_order_id']),
      sources: JsonMapperUtils.safeParseString(json['sources']),
      statusCode: JsonMapperUtils.safeParseString(json['status_code']),
      price: JsonMapperUtils.safeParseDouble(json['price']),
      voucherCode: JsonMapperUtils.safeParseString(json['voucher_code']),
      discount: JsonMapperUtils.safeParseDouble(json['discount']),
      shippingFee: JsonMapperUtils.safeParseDouble(json['shipping_fee']),
      surcharge: JsonMapperUtils.safeParseDouble(json['surcharge']),
      paidPrice: JsonMapperUtils.safeParseDouble(json['paid_price']),
      itemsCount: JsonMapperUtils.safeParseInt(json['items_count']),
      remarks: JsonMapperUtils.safeParseStringNullable(json['remarks']),
      customerId: JsonMapperUtils.safeParseInt(json['customer_id']),
      sellerId: JsonMapperUtils.safeParseInt(json['seller_id']),
      hasExportEinvoice: JsonMapperUtils.safeParseInt(json['has_export_einvoice']),
      orderAt: JsonMapperUtils.safeParseDateTime(json['order_at']),
      estimatedDeliveryDate: JsonMapperUtils.safeParseString(json['estimated_delivery_date']),
      type: JsonMapperUtils.safeParseString(json['type']),
      subOrderNumber: JsonMapperUtils.safeParseInt(json['sub_order_number']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      id: JsonMapperUtils.safeParseInt(json['id']),
      orderCode: JsonMapperUtils.safeParseString(json['order_code']),
      paymentMethodName: JsonMapperUtils.safeParseString(json['payment_method_name']),
    );
  }
}
