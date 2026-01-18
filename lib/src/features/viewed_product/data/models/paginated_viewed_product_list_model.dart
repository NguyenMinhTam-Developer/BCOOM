import '../../../../core/utils/json_mapper_utils.dart';
import '../../../search/data/models/pagination_model.dart';
import '../../domain/entities/paginated_viewed_product_list_entity.dart';
import 'viewed_product_model.dart';

class PaginatedViewedProductListModel extends PaginatedViewedProductListEntity {
  const PaginatedViewedProductListModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory PaginatedViewedProductListModel.fromJson(Map<String, dynamic> json) {
    final limit = JsonMapperUtils.safeParseInt(json['limit']);
    final total = JsonMapperUtils.safeParseInt(json['total']);

    return PaginatedViewedProductListModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => ViewedProductModel.fromJson(
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

