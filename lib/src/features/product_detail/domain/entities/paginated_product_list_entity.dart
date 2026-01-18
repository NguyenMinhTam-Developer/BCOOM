import '../../../search/domain/entities/pagination_entity.dart';
import '../../../search/domain/entities/search_product_entity.dart';

class PaginatedProductListEntity {
  final List<SearchProductEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const PaginatedProductListEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}

