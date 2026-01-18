import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/province_entity.dart';
import '../../domain/entities/location_list_entity.dart';

class ProvinceModel extends ProvinceEntity {
  ProvinceModel({
    required super.provinceCode,
    required super.name,
    required super.country,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      provinceCode: JsonMapperUtils.safeParseString(json['province_code']),
      name: JsonMapperUtils.safeParseString(json['name']),
      country: JsonMapperUtils.safeParseString(json['country']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province_code': provinceCode,
      'name': name,
      'country': country,
    };
  }
}

class ProvinceListModel extends ProvinceListEntity {
  ProvinceListModel({
    required super.provinces,
  });

  factory ProvinceListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final results = data['results'] as List<dynamic>? ?? [];

    return ProvinceListModel(
      provinces: JsonMapperUtils.safeParseList(
        results,
        mapper: (e) => ProvinceModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  // Factory for loading from cache (direct list)
  factory ProvinceListModel.fromJsonList(List<dynamic> jsonList) {
    return ProvinceListModel(
      provinces: JsonMapperUtils.safeParseList(
        jsonList,
        mapper: (e) => ProvinceModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provinces': provinces.map((e) {
        if (e is ProvinceModel) {
          return e.toJson();
        }
        // If it's a ProvinceEntity, convert it
        return {
          'province_code': e.provinceCode,
          'name': e.name,
          'country': e.country,
        };
      }).toList(),
    };
  }
}
