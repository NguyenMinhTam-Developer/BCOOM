import '../../../search/domain/entities/pagination_entity.dart';
import 'wishlist_product_entity.dart';

class PaginatedWishlistProductListEntity {
  final List<WishlistProductEntity> rows;
  final PaginationEntity pagination;
  final int limit;
  final int total;

  const PaginatedWishlistProductListEntity({
    required this.rows,
    required this.pagination,
    required this.limit,
    required this.total,
  });
}

