import 'pagination_entity.dart';
import 'suggestion_keyword_entity.dart';

class SuggestionKeywordListEntity {
  final List<SuggestionKeywordEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const SuggestionKeywordListEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}
