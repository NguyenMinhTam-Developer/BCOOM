import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/brand_list_entity.dart';
import 'brand_model.dart';

class BrandListModel extends BrandListEntity {
  const BrandListModel({
    required super.rows,
    required super.more,
    required super.limit,
    required super.total,
  });

  factory BrandListModel.fromJson(Map<String, dynamic> json) {
    final rows = JsonMapperUtils.safeParseList(
      json['rows'],
      mapper: (item) => BrandModel.fromJson(
        JsonMapperUtils.safeParseMap(item),
      ),
    );

    final pagination = JsonMapperUtils.safeParseMap(json['pagination']);

    return BrandListModel(
      rows: rows,
      more: JsonMapperUtils.safeParseBool(pagination['more']),
      limit: JsonMapperUtils.safeParseInt(json['limit']),
      total: JsonMapperUtils.safeParseInt(json['total']),
    );
  }
}
