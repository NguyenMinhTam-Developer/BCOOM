import '../../../../core/utils/json_mapper_utils.dart';
import '../../../search/data/models/pagination_model.dart';
import '../../domain/entities/paginated_wishlist_product_list_entity.dart';
import 'wishlist_product_model.dart';

class PaginatedWishlistProductListModel extends PaginatedWishlistProductListEntity {
  const PaginatedWishlistProductListModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory PaginatedWishlistProductListModel.fromJson(Map<String, dynamic> json) {
    final limit = JsonMapperUtils.safeParseInt(json['limit']);
    final total = JsonMapperUtils.safeParseInt(json['total']);

    return PaginatedWishlistProductListModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => WishlistProductModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      pagination: PaginationModel.fromJson(
        JsonMapperUtils.safeParseMap(json['pagination']),
      ),
      limit: limit,
      total: total,
    );
  }
}

