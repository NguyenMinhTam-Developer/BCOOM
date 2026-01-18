class CollectionEntity {
  final int id;
  final String name;
  final String slug;
  final String type;
  final Map<String, dynamic> rules;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int createdBy;
  final int updatedBy;

  const CollectionEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    required this.rules,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });
}
