import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/suggestion_keyword_list_entity.dart';
import 'pagination_model.dart';
import 'suggestion_keyword_model.dart';

class SuggestionKeywordListModel extends SuggestionKeywordListEntity {
  const SuggestionKeywordListModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory SuggestionKeywordListModel.fromJson(Map<String, dynamic> json) {
    return SuggestionKeywordListModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => SuggestionKeywordModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      pagination: PaginationModel.fromJson(
        JsonMapperUtils.safeParseMap(json['pagination']),
      ),
      limit: JsonMapperUtils.safeParseInt(json['limit']),
      total: JsonMapperUtils.safeParseInt(json['total']),
    );
  }
}
