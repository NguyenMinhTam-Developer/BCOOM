import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/ward_entity.dart';
import '../../domain/entities/location_list_entity.dart';

class WardModel extends WardEntity {
  WardModel({
    required super.wardCode,
    required super.name,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return WardModel(
      wardCode: JsonMapperUtils.safeParseString(json['ward_code']),
      name: JsonMapperUtils.safeParseString(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ward_code': wardCode,
      'name': name,
    };
  }
}

class WardListModel extends WardListEntity {
  WardListModel({
    required super.wards,
  });

  factory WardListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final results = data['results'] as List<dynamic>? ?? [];

    return WardListModel(
      wards: JsonMapperUtils.safeParseList(
        results,
        mapper: (e) => WardModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  // Factory for loading from cache (direct list)
  factory WardListModel.fromJsonList(List<dynamic> jsonList) {
    return WardListModel(
      wards: JsonMapperUtils.safeParseList(
        jsonList,
        mapper: (e) => WardModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wards': wards.map((e) {
        if (e is WardModel) {
          return e.toJson();
        }
        // If it's a WardEntity, convert it
        return {
          'ward_code': e.wardCode,
          'name': e.name,
        };
      }).toList(),
    };
  }
}
