import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/viewed_product_entity.dart';

class ViewedProductModel extends ViewedProductEntity {
  const ViewedProductModel({
    required super.id,
    required super.name,
    required super.code,
    required super.priceMarket,
    required super.priceSale,
    required super.rate,
    required super.imageUrl,
    required super.imageLocation,
    required super.viewedNumber,
    required super.viewedAt,
  });

  factory ViewedProductModel.fromJson(Map<String, dynamic> json) {
    return ViewedProductModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      code: JsonMapperUtils.safeParseString(json['code']),
      priceMarket: JsonMapperUtils.safeParseInt(json['price_market']),
      priceSale: JsonMapperUtils.safeParseInt(json['price_sale']),
      rate: JsonMapperUtils.safeParseDoubleNullable(json['rate']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseString(json['image_location']),
      viewedNumber: JsonMapperUtils.safeParseInt(json['viewed_number']),
      viewedAt: JsonMapperUtils.safeParseDateTimeNullable(json['viewed_at']),
    );
  }
}

