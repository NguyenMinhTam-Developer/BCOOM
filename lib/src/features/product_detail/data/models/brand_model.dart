import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.creator,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      creator: JsonMapperUtils.safeParseStringNullable(json['creator']),
    );
  }
}

