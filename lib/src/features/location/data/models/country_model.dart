import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/location_list_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    required super.countryId,
    required super.nameWithType,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryId: JsonMapperUtils.safeParseInt(json['country_id']),
      nameWithType: JsonMapperUtils.safeParseString(json['name_with_type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_id': countryId,
      'name_with_type': nameWithType,
    };
  }
}

class CountryListModel extends CountryListEntity {
  CountryListModel({
    required super.countries,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final results = data['results'] as List<dynamic>? ?? [];

    return CountryListModel(
      countries: JsonMapperUtils.safeParseList(
        results,
        mapper: (e) => CountryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  // Factory for loading from cache (direct list)
  factory CountryListModel.fromJsonList(List<dynamic> jsonList) {
    return CountryListModel(
      countries: JsonMapperUtils.safeParseList(
        jsonList,
        mapper: (e) => CountryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries': countries.map((e) {
        if (e is CountryModel) {
          return e.toJson();
        }
        // If it's a CountryEntity, convert it
        return {
          'country_id': e.countryId,
          'name_with_type': e.nameWithType,
        };
      }).toList(),
    };
  }
}
