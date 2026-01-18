class FaqEntity {
  final int id;
  final int categoryId;
  final String question;
  final String answer;
  final int viewNumber;
  final int status;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String site;
  final int objectId;
  final String categoryName;

  FaqEntity({
    required this.id,
    required this.categoryId,
    required this.question,
    required this.answer,
    required this.viewNumber,
    required this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.site,
    required this.objectId,
    required this.categoryName,
  });
}
