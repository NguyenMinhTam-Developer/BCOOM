import '../../../search/domain/entities/pagination_entity.dart';
import 'viewed_product_entity.dart';

class PaginatedViewedProductListEntity {
  final List<ViewedProductEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const PaginatedViewedProductListEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}

