import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/page_entity.dart';

class PageModel extends PageEntity {
  PageModel({
    required super.id,
    required super.template,
    required super.title,
    required super.slug,
    required super.pageName,
    required super.groupManage,
    super.position,
    required super.content,
    super.imageLocation,
    super.imageUrl,
    super.imageLink,
    super.extras,
    super.seoTitle,
    super.seoDescription,
    super.seoKeyword,
    super.createdBy,
    super.updatedBy,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    required super.status,
    super.pagePolicyId,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      template: JsonMapperUtils.safeParseString(json['template']),
      title: JsonMapperUtils.safeParseString(json['title']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      pageName: JsonMapperUtils.safeParseString(json['page_name']),
      groupManage: JsonMapperUtils.safeParseString(json['group_manage']),
      position: JsonMapperUtils.safeParseStringNullable(json['position']),
      content: JsonMapperUtils.safeParseString(json['content']),
      imageLocation: JsonMapperUtils.safeParseStringNullable(json['image_location']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']),
      imageLink: JsonMapperUtils.safeParseStringNullable(json['image_link']),
      extras: json['extras'],
      seoTitle: JsonMapperUtils.safeParseStringNullable(json['seo_title']),
      seoDescription: JsonMapperUtils.safeParseStringNullable(json['seo_description']),
      seoKeyword: JsonMapperUtils.safeParseStringNullable(json['seo_keyword']),
      createdBy: JsonMapperUtils.safeParseIntNullable(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseIntNullable(json['updated_by']),
      createdAt: JsonMapperUtils.safeParseDateTimeNullable(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTimeNullable(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      status: JsonMapperUtils.safeParseInt(json['status']),
      pagePolicyId: JsonMapperUtils.safeParseIntNullable(json['page_policy_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'template': template,
      'title': title,
      'slug': slug,
      'page_name': pageName,
      'group_manage': groupManage,
      'position': position,
      'content': content,
      'image_location': imageLocation,
      'image_url': imageUrl,
      'image_link': imageLink,
      'extras': extras,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'seo_keyword': seoKeyword,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'status': status,
      'page_policy_id': pagePolicyId,
    };
  }
}
