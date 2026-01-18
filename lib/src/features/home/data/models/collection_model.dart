import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/collection_entity.dart';

class CollectionModel extends CollectionEntity {
  const CollectionModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.type,
    required super.rules,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.createdBy,
    required super.updatedBy,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      type: JsonMapperUtils.safeParseString(json['type']),
      rules: JsonMapperUtils.safeParseMap(json['rules']),
      status: JsonMapperUtils.safeParseInt(json['status']),
      createdAt: JsonMapperUtils.safeParseString(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseString(json['updated_at']),
      createdBy: JsonMapperUtils.safeParseInt(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseInt(json['updated_by']),
    );
  }
}

