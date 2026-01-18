import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/suggestion_keyword_entity.dart';

class SuggestionKeywordModel extends SuggestionKeywordEntity {
  const SuggestionKeywordModel({
    required super.keyword,
  });

  factory SuggestionKeywordModel.fromJson(Map<String, dynamic> json) {
    return SuggestionKeywordModel(
      keyword: JsonMapperUtils.safeParseString(json['keyword']),
    );
  }
}
