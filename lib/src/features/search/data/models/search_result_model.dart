import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/search_result_entity.dart';
import 'pagination_model.dart';
import 'search_product_model.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required super.rows,
    required super.pagination,
    required super.limit,
    required super.total,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (e) => SearchProductModel.fromJson(
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
