import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/product_image_entity.dart';

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

