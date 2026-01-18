import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/faq_entity.dart';
import '../../domain/entities/faq_list_entity.dart';

class FaqModel extends FaqEntity {
  FaqModel({
    required super.id,
    required super.categoryId,
    required super.question,
    required super.answer,
    required super.viewNumber,
    required super.status,
    super.createdBy,
    super.updatedBy,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    required super.site,
    required super.objectId,
    required super.categoryName,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      categoryId: JsonMapperUtils.safeParseInt(json['category_id']),
      question: JsonMapperUtils.safeParseString(json['question']),
      answer: JsonMapperUtils.safeParseString(json['answer']),
      viewNumber: JsonMapperUtils.safeParseInt(json['view_number'] ?? 0),
      status: JsonMapperUtils.safeParseInt(json['status']),
      createdBy: JsonMapperUtils.safeParseIntNullable(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseIntNullable(json['updated_by']),
      createdAt: JsonMapperUtils.safeParseDateTimeNullable(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTimeNullable(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      site: JsonMapperUtils.safeParseString(json['site']),
      objectId: JsonMapperUtils.safeParseInt(json['object_id'] ?? 0),
      categoryName: JsonMapperUtils.safeParseString(json['category_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'question': question,
      'answer': answer,
      'view_number': viewNumber,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'site': site,
      'object_id': objectId,
      'category_name': categoryName,
    };
  }
}

class FaqListModel extends FaqListEntity {
  FaqListModel({
    required super.rows,
    required super.more,
    required super.limit,
    required super.total,
  });

  factory FaqListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final rows = data['rows'] as List<dynamic>? ?? [];
    final pagination = data['pagination'] as Map<String, dynamic>? ?? {};

    return FaqListModel(
      rows: JsonMapperUtils.safeParseList(
        rows,
        mapper: (e) => FaqModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      more: JsonMapperUtils.safeParseBool(pagination['more'], defaultValue: false),
      limit: JsonMapperUtils.safeParseString(data['limit'] ?? '0'),
      total: JsonMapperUtils.safeParseInt(data['total'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rows': rows.map((e) {
        if (e is FaqModel) {
          return e.toJson();
        }
        return {
          'id': e.id,
          'category_id': e.categoryId,
          'question': e.question,
          'answer': e.answer,
          'view_number': e.viewNumber,
          'status': e.status,
          'created_by': e.createdBy,
          'updated_by': e.updatedBy,
          'created_at': e.createdAt?.toIso8601String(),
          'updated_at': e.updatedAt?.toIso8601String(),
          'deleted_at': e.deletedAt?.toIso8601String(),
          'site': e.site,
          'object_id': e.objectId,
          'category_name': e.categoryName,
        };
      }).toList(),
      'pagination': {
        'more': more,
      },
      'limit': limit,
      'total': total,
    };
  }
}
