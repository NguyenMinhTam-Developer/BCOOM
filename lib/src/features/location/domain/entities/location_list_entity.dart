import 'country_entity.dart';
import 'province_entity.dart';
import 'ward_entity.dart';

class CountryListEntity {
  final List<CountryEntity> countries;

  CountryListEntity({
    required this.countries,
  });
}

class ProvinceListEntity {
  final List<ProvinceEntity> provinces;

  ProvinceListEntity({
    required this.provinces,
  });
}

class WardListEntity {
  final List<WardEntity> wards;

  WardListEntity({
    required this.wards,
  });
}
