class PageEntity {
  final int id;
  final String template;
  final String title;
  final String slug;
  final String pageName;
  final String groupManage;
  final String? position;
  final String content;
  final String? imageLocation;
  final String? imageUrl;
  final String? imageLink;
  final dynamic extras;
  final String? seoTitle;
  final String? seoDescription;
  final String? seoKeyword;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int status;
  final int? pagePolicyId;

  PageEntity({
    required this.id,
    required this.template,
    required this.title,
    required this.slug,
    required this.pageName,
    required this.groupManage,
    this.position,
    required this.content,
    this.imageLocation,
    this.imageUrl,
    this.imageLink,
    this.extras,
    this.seoTitle,
    this.seoDescription,
    this.seoKeyword,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.status,
    this.pagePolicyId,
  });
}
