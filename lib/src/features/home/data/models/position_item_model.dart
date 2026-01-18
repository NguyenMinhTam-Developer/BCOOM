import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/position_item_entity.dart';

class PositionItemModel extends PositionItemEntity {
  const PositionItemModel({
    required super.homePositionImageId,
    required super.homePositionId,
    required super.ordering,
    required super.imageUrl,
    required super.imageLocation,
    required super.imageChildUrl,
    required super.imageChildLocation,
    required super.link,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.locale,
    required super.title,
    required super.description,
    required super.titleLink,
  });

  factory PositionItemModel.fromJson(Map<String, dynamic> json) {
    return PositionItemModel(
      homePositionImageId: JsonMapperUtils.safeParseInt(json['home_position_image_id']),
      homePositionId: JsonMapperUtils.safeParseInt(json['home_position_id']),
      ordering: JsonMapperUtils.safeParseInt(json['ordering']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseStringNullable(json['image_location']),
      imageChildUrl: JsonMapperUtils.safeParseStringNullable(json['image_child_url']),
      imageChildLocation: JsonMapperUtils.safeParseStringNullable(json['image_child_location']),
      link: JsonMapperUtils.safeParseStringNullable(json['link']),
      status: JsonMapperUtils.safeParseInt(json['status']),
      createdAt: JsonMapperUtils.safeParseDateTimeNullable(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTimeNullable(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      locale: JsonMapperUtils.safeParseString(json['locale']),
      title: JsonMapperUtils.safeParseStringNullable(json['title']),
      description: JsonMapperUtils.safeParseStringNullable(json['description']),
      titleLink: JsonMapperUtils.safeParseStringNullable(json['title_link']),
    );
  }
}
