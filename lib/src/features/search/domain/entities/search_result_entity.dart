import 'pagination_entity.dart';
import 'search_product_entity.dart';

class SearchResultEntity {
  final List<SearchProductEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const SearchResultEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}
