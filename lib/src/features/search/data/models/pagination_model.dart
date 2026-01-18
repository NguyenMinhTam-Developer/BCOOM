import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/pagination_entity.dart';

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.more,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      more: JsonMapperUtils.safeParseBool(json['more']),
    );
  }
}
