class PositionItemEntity {
  final int homePositionImageId;
  final int homePositionId;
  final int ordering;
  final String? imageUrl;
  final String? imageLocation;
  final String? imageChildUrl;
  final String? imageChildLocation;
  final String? link;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String locale;
  final String? title;
  final String? description;
  final String? titleLink;

  const PositionItemEntity({
    required this.homePositionImageId,
    required this.homePositionId,
    required this.ordering,
    required this.imageUrl,
    required this.imageLocation,
    required this.imageChildUrl,
    required this.imageChildLocation,
    required this.link,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.locale,
    required this.title,
    required this.description,
    required this.titleLink,
  });
}
