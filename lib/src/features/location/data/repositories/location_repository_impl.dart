import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/location_list_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';
import '../datasources/location_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CountryListEntity>> getCountries() async {
    try {
      // Try to get from cache first
      final cachedCountries = await localDataSource.getCachedCountries();
      if (cachedCountries != null && cachedCountries.countries.isNotEmpty) {
        return Right(cachedCountries);
      }

      // If cache is empty, fetch from remote
      final response = await remoteDataSource.getCountries();

      // Save to cache
      await localDataSource.cacheCountries(response);

      return Right(response);
    } on HttpException catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi tải danh sách quốc gia',
        message: e.description ?? 'Lỗi tải danh sách quốc gia',
      ));
    } catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, ProvinceListEntity>> getProvinces() async {
    try {
      // Try to get from cache first
      final cachedProvinces = await localDataSource.getCachedProvinces();
      if (cachedProvinces != null && cachedProvinces.provinces.isNotEmpty) {
        return Right(cachedProvinces);
      }

      // If cache is empty, fetch from remote
      final response = await remoteDataSource.getProvinces();

      // Save to cache
      await localDataSource.cacheProvinces(response);

      return Right(response);
    } on HttpException catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi tải danh sách tỉnh/thành phố',
        message: e.description ?? 'Lỗi tải danh sách tỉnh/thành phố',
      ));
    } catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, WardListEntity>> getWards({
    required String districtId,
  }) async {
    try {
      // Try to get from cache first
      final cachedWards = await localDataSource.getCachedWards(districtId);
      if (cachedWards != null && cachedWards.wards.isNotEmpty) {
        return Right(cachedWards);
      }

      // If cache is empty, fetch from remote
      final response = await remoteDataSource.getWards(districtId: districtId);

      // Save to cache
      await localDataSource.cacheWards(districtId, response);

      return Right(response);
    } on HttpException catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi tải danh sách phường/xã',
        message: e.description ?? 'Lỗi tải danh sách phường/xã',
      ));
    } catch (e) {
      return Left(LocationFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
