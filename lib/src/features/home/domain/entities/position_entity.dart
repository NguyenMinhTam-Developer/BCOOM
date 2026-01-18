import 'position_item_entity.dart';

class PositionEntity {
  final int id;
  final int landingPageId;
  final int positionTypeId;
  final String name;
  final int status;
  final int ordering;
  final int orderingBlock;
  final String? imageLocation;
  final String? imageUrl;
  final String? youtube;
  final String? map;
  final int? width;
  final int? height;
  final String? keywords;
  final String? linkMore;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int homePositionId;
  final String locale;
  final String? content;
  final String? title;
  final int? createdBy;
  final int? updatedBy;
  final String homePositionType;
  final String homePositionTypeKey;
  final List<PositionItemEntity> items;

  const PositionEntity({
    required this.id,
    required this.landingPageId,
    required this.positionTypeId,
    required this.name,
    required this.status,
    required this.ordering,
    required this.orderingBlock,
    required this.imageLocation,
    required this.imageUrl,
    required this.youtube,
    required this.map,
    required this.width,
    required this.height,
    required this.keywords,
    required this.linkMore,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.homePositionId,
    required this.locale,
    required this.content,
    required this.title,
    required this.createdBy,
    required this.updatedBy,
    required this.homePositionType,
    required this.homePositionTypeKey,
    required this.items,
  });
}
