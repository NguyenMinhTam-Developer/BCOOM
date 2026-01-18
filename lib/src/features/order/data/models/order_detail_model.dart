import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/order_detail_entity.dart';
import 'order_model.dart';

class ProductImageModel extends ProductImageEntity {
  const ProductImageModel({
    required super.id,
    required super.productId,
    required super.imageUrl,
    required super.imageLocation,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      productId: JsonMapperUtils.safeParseInt(json['product_id']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseString(json['image_location']),
    );
  }
}

class VariantModel extends VariantEntity {
  const VariantModel({
    required super.id,
    super.site,
    super.objectId,
    super.parentCategoryId,
    super.categoryId,
    super.filterCategoryId,
    super.masterProductId,
    required super.numberOrdered,
    required super.amountInventory,
    super.type,
    super.rate,
    super.code,
    super.barCode,
    required super.name,
    super.alias,
    super.fullName,
    required super.hasSubProduct,
    super.nameSlug,
    required super.priceBase,
    required super.priceSale,
    super.priceMarket,
    super.price,
    super.priceApplyTime,
    super.industryId,
    super.supplierId,
    super.brandId,
    super.unitId,
    super.categoryFoodId,
    super.subDescription,
    super.description,
    super.configurationInfo,
    super.extras,
    super.imageUrl,
    super.imageLocation,
    super.weight,
    super.length,
    super.width,
    super.height,
    required super.status,
    super.statusId,
    super.createdBy,
    super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
    super.sku,
    super.customerScope,
    required super.productImages,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      site: JsonMapperUtils.safeParseStringNullable(json['site']),
      objectId: JsonMapperUtils.safeParseIntNullable(json['object_id']),
      parentCategoryId: JsonMapperUtils.safeParseIntNullable(json['parent_category_id']),
      categoryId: JsonMapperUtils.safeParseStringNullable(json['category_id']),
      filterCategoryId: JsonMapperUtils.safeParseStringNullable(json['filter_category_id']),
      masterProductId: JsonMapperUtils.safeParseIntNullable(json['master_product_id']),
      numberOrdered: JsonMapperUtils.safeParseInt(json['number_ordered']),
      amountInventory: JsonMapperUtils.safeParseInt(json['amount_inventory']),
      type: JsonMapperUtils.safeParseStringNullable(json['type']),
      rate: JsonMapperUtils.safeParseDoubleNullable(json['rate']),
      code: JsonMapperUtils.safeParseStringNullable(json['code']),
      barCode: JsonMapperUtils.safeParseStringNullable(json['bar_code']),
      name: JsonMapperUtils.safeParseString(json['name']),
      alias: JsonMapperUtils.safeParseStringNullable(json['alias']),
      fullName: JsonMapperUtils.safeParseStringNullable(json['full_name']),
      hasSubProduct: JsonMapperUtils.safeParseInt(json['has_sub_product']),
      nameSlug: JsonMapperUtils.safeParseStringNullable(json['name_slug']),
      priceBase: JsonMapperUtils.safeParseInt(json['price_base']),
      priceSale: JsonMapperUtils.safeParseInt(json['price_sale']),
      priceMarket: JsonMapperUtils.safeParseIntNullable(json['price_market']),
      price: JsonMapperUtils.safeParseIntNullable(json['price']),
      priceApplyTime: JsonMapperUtils.safeParseStringNullable(json['price_apply_time']),
      industryId: JsonMapperUtils.safeParseIntNullable(json['industry_id']),
      supplierId: JsonMapperUtils.safeParseIntNullable(json['supplier_id']),
      brandId: JsonMapperUtils.safeParseIntNullable(json['brand_id']),
      unitId: JsonMapperUtils.safeParseIntNullable(json['unit_id']),
      categoryFoodId: JsonMapperUtils.safeParseIntNullable(json['category_food_id']),
      subDescription: JsonMapperUtils.safeParseStringNullable(json['sub_description']),
      description: JsonMapperUtils.safeParseStringNullable(json['description']),
      configurationInfo: JsonMapperUtils.safeParseStringNullable(json['configuration_info']),
      extras: JsonMapperUtils.safeParseStringNullable(json['extras']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseStringNullable(json['image_location']),
      weight: JsonMapperUtils.safeParseIntNullable(json['weight']),
      length: JsonMapperUtils.safeParseIntNullable(json['length']),
      width: JsonMapperUtils.safeParseIntNullable(json['width']),
      height: JsonMapperUtils.safeParseIntNullable(json['height']),
      status: JsonMapperUtils.safeParseInt(json['status']),
      statusId: JsonMapperUtils.safeParseIntNullable(json['status_id']),
      createdBy: JsonMapperUtils.safeParseIntNullable(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseIntNullable(json['updated_by']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      sku: JsonMapperUtils.safeParseStringNullable(json['sku']),
      customerScope: JsonMapperUtils.safeParseStringNullable(json['customer_scope']),
      productImages: JsonMapperUtils.safeParseList(
        json['product_images'],
        mapper: (e) => ProductImageModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.parentOrderId,
    required super.sku,
    required super.productId,
    required super.variantId,
    required super.name,
    super.imageUrl,
    super.detailUrl,
    required super.itemPrice,
    required super.paidPrice,
    required super.quantity,
    required super.shippingFee,
    required super.voucherCode,
    super.warehouseCode,
    required super.status,
    super.extraAttributes,
    required super.createdAt,
    required super.updatedAt,
    super.variant,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      orderId: JsonMapperUtils.safeParseInt(json['order_id']),
      parentOrderId: JsonMapperUtils.safeParseInt(json['parent_order_id']),
      sku: JsonMapperUtils.safeParseString(json['sku']),
      productId: JsonMapperUtils.safeParseInt(json['product_id']),
      variantId: JsonMapperUtils.safeParseInt(json['variant_id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']),
      detailUrl: JsonMapperUtils.safeParseStringNullable(json['detail_url']),
      itemPrice: JsonMapperUtils.safeParseInt(json['item_price']),
      paidPrice: JsonMapperUtils.safeParseInt(json['paid_price']),
      quantity: JsonMapperUtils.safeParseInt(json['quantity']),
      shippingFee: JsonMapperUtils.safeParseInt(json['shipping_fee']),
      voucherCode: JsonMapperUtils.safeParseString(json['voucher_code'] ?? ''),
      warehouseCode: JsonMapperUtils.safeParseStringNullable(json['warehouse_code']),
      status: JsonMapperUtils.safeParseString(json['status'] ?? ''),
      extraAttributes: JsonMapperUtils.safeParseMapNullable(json['extra_attributes']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      variant: json['variant'] != null
          ? VariantModel.fromJson(JsonMapperUtils.safeParseMap(json['variant']))
          : null,
    );
  }
}

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required super.id,
    required super.orderId,
    required super.name,
    required super.phone,
    super.email,
    required super.street,
    super.building,
    super.gate,
    required super.distance,
    super.lat,
    super.lng,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      orderId: JsonMapperUtils.safeParseInt(json['order_id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      phone: JsonMapperUtils.safeParseString(json['phone']),
      email: JsonMapperUtils.safeParseStringNullable(json['email']),
      street: JsonMapperUtils.safeParseString(json['street']),
      building: JsonMapperUtils.safeParseStringNullable(json['building']),
      gate: JsonMapperUtils.safeParseStringNullable(json['gate']),
      distance: JsonMapperUtils.safeParseInt(json['distance']),
      lat: JsonMapperUtils.safeParseDoubleNullable(json['lat']),
      lng: JsonMapperUtils.safeParseDoubleNullable(json['lng']),
    );
  }
}

class OrderDetailModel extends OrderDetailEntity {
  const OrderDetailModel({
    required super.id,
    required super.orderCode,
    required super.createdAt,
    required super.itemsCount,
    required super.price,
    super.voucherCode,
    required super.discount,
    required super.discountPlatform,
    required super.discountSeller,
    required super.shippingFee,
    required super.surcharge,
    required super.paidPrice,
    super.remarks,
    required super.statusCode,
    super.type,
    super.statusName,
    super.statusBackgroundColor,
    super.statusTextColor,
    required super.sellerId,
    required super.sellerName,
    required super.sellerPhone,
    super.sellerAddress,
    required super.payment,
    super.shippingAddress,
    required super.suborders,
    required super.items,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      orderCode: JsonMapperUtils.safeParseString(json['order_code']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      itemsCount: JsonMapperUtils.safeParseInt(json['items_count']),
      price: JsonMapperUtils.safeParseInt(json['price']),
      voucherCode: JsonMapperUtils.safeParseStringNullable(json['voucher_code']),
      discount: JsonMapperUtils.safeParseInt(json['discount']),
      discountPlatform: JsonMapperUtils.safeParseInt(json['discount_platform']),
      discountSeller: JsonMapperUtils.safeParseInt(json['discount_seller']),
      shippingFee: JsonMapperUtils.safeParseInt(json['shipping_fee']),
      surcharge: JsonMapperUtils.safeParseInt(json['surcharge']),
      paidPrice: JsonMapperUtils.safeParseInt(json['paid_price']),
      remarks: JsonMapperUtils.safeParseStringNullable(json['remarks']),
      statusCode: JsonMapperUtils.safeParseString(json['status_code']),
      type: JsonMapperUtils.safeParseStringNullable(json['type']),
      statusName: JsonMapperUtils.safeParseStringNullable(json['status_name']),
      statusBackgroundColor: JsonMapperUtils.safeParseStringNullable(json['status_background_color']),
      statusTextColor: JsonMapperUtils.safeParseStringNullable(json['status_text_color']),
      sellerId: JsonMapperUtils.safeParseInt(json['seller_id']),
      sellerName: JsonMapperUtils.safeParseString(json['seller_name']),
      sellerPhone: JsonMapperUtils.safeParseString(json['seller_phone']),
      sellerAddress: JsonMapperUtils.safeParseStringNullable(json['seller_address']),
      payment: OrderPaymentModel.fromJson(
        JsonMapperUtils.safeParseMap(json['payment']),
      ),
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddressModel.fromJson(
              JsonMapperUtils.safeParseMap(json['shipping_address']),
            )
          : null,
      suborders: JsonMapperUtils.safeParseList(
        json['suborders'],
        mapper: (e) => e,
      ),
      items: JsonMapperUtils.safeParseList(
        json['items'],
        mapper: (e) => OrderItemModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}
