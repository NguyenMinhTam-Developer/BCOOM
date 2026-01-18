import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/location_list_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, CountryListEntity>> getCountries();

  Future<Either<Failure, ProvinceListEntity>> getProvinces();

  Future<Either<Failure, WardListEntity>> getWards({
    required String districtId,
  });
}
