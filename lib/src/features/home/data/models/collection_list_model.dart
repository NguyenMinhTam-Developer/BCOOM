import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/collection_list_entity.dart';
import 'collection_model.dart';

class CollectionListModel extends CollectionListEntity {
  const CollectionListModel({
    required super.rows,
    required super.more,
    required super.limit,
    required super.total,
  });

  factory CollectionListModel.fromJson(Map<String, dynamic> json) {
    final rows = JsonMapperUtils.safeParseList(
      json['rows'],
      mapper: (item) => CollectionModel.fromJson(
        JsonMapperUtils.safeParseMap(item),
      ),
    );

    final pagination = JsonMapperUtils.safeParseMap(json['pagination']);

    return CollectionListModel(
      rows: rows,
      more: JsonMapperUtils.safeParseBool(pagination['more']),
      limit: JsonMapperUtils.safeParseInt(json['limit']),
      total: JsonMapperUtils.safeParseInt(json['total']),
    );
  }
}
