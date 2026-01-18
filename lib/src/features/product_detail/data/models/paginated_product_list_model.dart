import '../../../../core/utils/json_mapper_utils.dart';
import '../../../search/data/models/pagination_model.dart';
import '../../../search/data/models/search_product_model.dart';
import '../../domain/entities/paginated_product_list_entity.dart';

class PaginatedProductListModel extends PaginatedProductListEntity {
  const PaginatedProductListModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory PaginatedProductListModel.fromJson(Map<String, dynamic> json) {
    final limit = JsonMapperUtils.safeParseInt(json['limit']);
    final total = JsonMapperUtils.safeParseInt(json['total']);

    return PaginatedProductListModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => SearchProductModel.fromJson(
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
