import 'dart:convert';

import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/location_list_entity.dart';
import '../models/country_model.dart';
import '../models/province_model.dart';
import '../models/ward_model.dart';

abstract class LocationLocalDataSource {
  Future<CountryListEntity?> getCachedCountries();
  Future<void> cacheCountries(CountryListEntity countries);

  Future<ProvinceListEntity?> getCachedProvinces();
  Future<void> cacheProvinces(ProvinceListEntity provinces);

  Future<WardListEntity?> getCachedWards(String districtId);
  Future<void> cacheWards(String districtId, WardListEntity wards);

  Future<Map<String, WardListEntity>> getAllCachedWards();
  Future<void> clearCache();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final LocalStorageService _localStorageService;

  static const String _countriesKey = 'location_countries';
  static const String _provincesKey = 'location_provinces';
  static const String _wardsPrefix = 'location_wards_';

  LocationLocalDataSourceImpl({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  @override
  Future<CountryListEntity?> getCachedCountries() async {
    try {
      final jsonString = _localStorageService.readData<String>(_countriesKey);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final countriesList = json['countries'] as List<dynamic>?;
      if (countriesList == null || countriesList.isEmpty) return null;

      return CountryListModel.fromJsonList(countriesList);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheCountries(CountryListEntity countries) async {
    try {
      final json = (countries as CountryListModel).toJson();
      final jsonString = jsonEncode(json);
      await _localStorageService.saveData(_countriesKey, jsonString);
    } catch (e) {
      // Silently fail caching
    }
  }

  @override
  Future<ProvinceListEntity?> getCachedProvinces() async {
    try {
      final jsonString = _localStorageService.readData<String>(_provincesKey);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final provincesList = json['provinces'] as List<dynamic>?;
      if (provincesList == null || provincesList.isEmpty) return null;

      return ProvinceListModel.fromJsonList(provincesList);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheProvinces(ProvinceListEntity provinces) async {
    try {
      final json = (provinces as ProvinceListModel).toJson();
      final jsonString = jsonEncode(json);
      await _localStorageService.saveData(_provincesKey, jsonString);
    } catch (e) {
      // Silently fail caching
    }
  }

  @override
  Future<WardListEntity?> getCachedWards(String districtId) async {
    try {
      final key = '$_wardsPrefix$districtId';
      final jsonString = _localStorageService.readData<String>(key);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final wardsList = json['wards'] as List<dynamic>?;
      if (wardsList == null || wardsList.isEmpty) return null;

      return WardListModel.fromJsonList(wardsList);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheWards(String districtId, WardListEntity wards) async {
    try {
      final key = '$_wardsPrefix$districtId';
      final json = (wards as WardListModel).toJson();
      final jsonString = jsonEncode(json);
      await _localStorageService.saveData(key, jsonString);
    } catch (e) {
      // Silently fail caching
    }
  }

  @override
  Future<Map<String, WardListEntity>> getAllCachedWards() async {
    // This method is not needed for current implementation
    // Wards are cached per districtId when fetched
    return {};
  }

  @override
  Future<void> clearCache() async {
    try {
      await _localStorageService.removeData(_countriesKey);
      await _localStorageService.removeData(_provincesKey);
      // Note: Individual ward caches will be cleared when needed
      // or can be cleared manually by removing specific keys
    } catch (e) {
      // Silently fail
    }
  }
}
