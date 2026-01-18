class CartOrderEntity {
  final int parentOrderId;
  final String sources;
  final String statusCode;
  final num price;
  final String voucherCode;
  final num discount;
  final num shippingFee;
  final num surcharge;
  final num paidPrice;
  final int itemsCount;
  final String? remarks;
  final int customerId;
  final int sellerId;
  final int hasExportEinvoice;
  final DateTime orderAt;
  final String estimatedDeliveryDate;
  final String type;
  final int subOrderNumber;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final String orderCode;
  final String paymentMethodName;

  CartOrderEntity({
    required this.parentOrderId,
    required this.sources,
    required this.statusCode,
    required this.price,
    required this.voucherCode,
    required this.discount,
    required this.shippingFee,
    required this.surcharge,
    required this.paidPrice,
    required this.itemsCount,
    this.remarks,
    required this.customerId,
    required this.sellerId,
    required this.hasExportEinvoice,
    required this.orderAt,
    required this.estimatedDeliveryDate,
    required this.type,
    required this.subOrderNumber,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.orderCode,
    required this.paymentMethodName,
  });
}
