import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/position_entity.dart';
import 'position_item_model.dart';

class PositionModel extends PositionEntity {
  const PositionModel({
    required super.id,
    required super.landingPageId,
    required super.positionTypeId,
    required super.name,
    required super.status,
    required super.ordering,
    required super.orderingBlock,
    required super.imageLocation,
    required super.imageUrl,
    required super.youtube,
    required super.map,
    required super.width,
    required super.height,
    required super.keywords,
    required super.linkMore,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.homePositionId,
    required super.locale,
    required super.content,
    required super.title,
    required super.createdBy,
    required super.updatedBy,
    required super.homePositionType,
    required super.homePositionTypeKey,
    required super.items,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    final items = JsonMapperUtils.safeParseList(
      json['items'],
      mapper: (item) => PositionItemModel.fromJson(
        JsonMapperUtils.safeParseMap(item),
      ),
    );

    return PositionModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      landingPageId: JsonMapperUtils.safeParseInt(json['landing_page_id']),
      positionTypeId: JsonMapperUtils.safeParseInt(json['position_type_id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      status: JsonMapperUtils.safeParseInt(json['status']),
      ordering: JsonMapperUtils.safeParseInt(json['ordering']),
      orderingBlock: JsonMapperUtils.safeParseInt(json['ordering_block']),
      imageLocation: JsonMapperUtils.safeParseStringNullable(json['image_location']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']),
      youtube: JsonMapperUtils.safeParseStringNullable(json['youtube']),
      map: JsonMapperUtils.safeParseStringNullable(json['map']),
      width: JsonMapperUtils.safeParseIntNullable(json['width']),
      height: JsonMapperUtils.safeParseIntNullable(json['height']),
      keywords: JsonMapperUtils.safeParseStringNullable(json['keywords']),
      linkMore: JsonMapperUtils.safeParseStringNullable(json['link_more']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      homePositionId: JsonMapperUtils.safeParseInt(json['home_position_id']),
      locale: JsonMapperUtils.safeParseString(json['locale']),
      content: JsonMapperUtils.safeParseStringNullable(json['content']),
      title: JsonMapperUtils.safeParseStringNullable(json['title']),
      createdBy: JsonMapperUtils.safeParseIntNullable(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseIntNullable(json['updated_by']),
      homePositionType: JsonMapperUtils.safeParseString(json['home_position_type']),
      homePositionTypeKey: JsonMapperUtils.safeParseString(json['home_position_type_key']),
      items: items,
    );
  }
}
