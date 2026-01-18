import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/filter_entity.dart';

class FilterPivotModel extends FilterPivotEntity {
  const FilterPivotModel({
    required super.productId,
    required super.filterId,
  });

  factory FilterPivotModel.fromJson(Map<String, dynamic> json) {
    return FilterPivotModel(
      productId: JsonMapperUtils.safeParseInt(json['product_id']),
      filterId: JsonMapperUtils.safeParseInt(json['filter_id']),
    );
  }
}

class FilterModel extends FilterEntity {
  const FilterModel({
    required super.id,
    required super.name,
    required super.creator,
    required super.pivot,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      creator: JsonMapperUtils.safeParseStringNullable(json['creator']),
      pivot: FilterPivotModel.fromJson(
        JsonMapperUtils.safeParseMap(json['pivot']),
      ),
    );
  }
}
