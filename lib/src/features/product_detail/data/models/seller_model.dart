import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/seller_entity.dart';

class SellerModel extends SellerEntity {
  const SellerModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.imageUrl,
    required super.imageLocation,
    required super.industries,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseString(json['image_location']),
      industries: JsonMapperUtils.safeParseList(
        json['industries'],
        mapper: (e) => e,
      ),
    );
  }
}

