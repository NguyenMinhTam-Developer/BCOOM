import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/faq_category_entity.dart';
import '../../domain/entities/faq_category_list_entity.dart';

class FaqCategoryModel extends FaqCategoryEntity {
  FaqCategoryModel({
    required super.id,
    required super.name,
    super.description,
    required super.imageView,
  });

  factory FaqCategoryModel.fromJson(Map<String, dynamic> json) {
    return FaqCategoryModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      description: JsonMapperUtils.safeParseStringNullable(json['description']),
      imageView: JsonMapperUtils.safeParseString(json['image_view']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_view': imageView,
    };
  }
}

class FaqCategoryListModel extends FaqCategoryListEntity {
  FaqCategoryListModel({
    required super.rows,
    required super.more,
    required super.limit,
    required super.total,
  });

  factory FaqCategoryListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final rows = data['rows'] as List<dynamic>? ?? [];
    final pagination = data['pagination'] as Map<String, dynamic>? ?? {};

    return FaqCategoryListModel(
      rows: JsonMapperUtils.safeParseList(
        rows,
        mapper: (e) => FaqCategoryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      more: JsonMapperUtils.safeParseBool(pagination['more'], defaultValue: false),
      limit: JsonMapperUtils.safeParseInt(data['limit'] ?? 0),
      total: JsonMapperUtils.safeParseInt(data['total'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rows': rows.map((e) {
        if (e is FaqCategoryModel) {
          return e.toJson();
        }
        return {
          'id': e.id,
          'name': e.name,
          'description': e.description,
          'image_view': e.imageView,
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
