import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/wishlist_product_entity.dart';

class WishlistProductModel extends WishlistProductEntity {
  const WishlistProductModel({
    required super.id,
    required super.name,
    required super.code,
    required super.priceMarket,
    required super.priceSale,
    required super.rate,
    required super.imageUrl,
    required super.imageLocation,
    required super.wishlistAt,
  });

  factory WishlistProductModel.fromJson(Map<String, dynamic> json) {
    return WishlistProductModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      code: JsonMapperUtils.safeParseString(json['code']),
      priceMarket: JsonMapperUtils.safeParseInt(json['price_market']),
      priceSale: JsonMapperUtils.safeParseInt(json['price_sale']),
      rate: JsonMapperUtils.safeParseDoubleNullable(json['rate']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseString(json['image_location']),
      wishlistAt: JsonMapperUtils.safeParseDateTimeNullable(json['wishlist_at']),
    );
  }
}

