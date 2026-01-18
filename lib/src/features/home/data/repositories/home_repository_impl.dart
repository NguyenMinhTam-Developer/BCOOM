import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/brand_list_entity.dart';
import '../../domain/entities/collection_list_entity.dart';
import '../../domain/entities/landing_page_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../source/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<HomeFailure, LandingPageEntity>> getLandingPage() async {
    try {
      final response = await remoteDataSource.getLandingPage();
      return Right(response);
    } on HttpException catch (e) {
      return Left(HomeFailure(title: 'Lỗi tải trang chủ', message: e.description ?? 'Lỗi tải trang chủ'));
    } catch (e) {
      return Left(HomeFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<HomeFailure, Map<String, dynamic>>> getRawLandingPage() async {
    try {
      final response = await remoteDataSource.getRawLandingPage();
      return Right(response);
    } on HttpException catch (e) {
      return Left(HomeFailure(title: 'Lỗi tải trang chủ', message: e.description ?? 'Lỗi tải trang chủ'));
    } catch (e) {
      return Left(HomeFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<HomeFailure, BrandListEntity>> getBrandList({
    required num? categoryId,
    required num? limit,
    required num? offset,
    required num? page,
    required String? search,
    required String? sort,
  }) async {
    try {
      final response = await remoteDataSource.getBrandList(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
        page: page,
        search: search,
        sort: sort,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HomeFailure(title: 'Lỗi tải danh sách thương hiệu', message: e.description ?? 'Lỗi tải danh sách thương hiệu'));
    } catch (e) {
      return Left(HomeFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<HomeFailure, Map<String, dynamic>>> getHomeProduct(Map<String, dynamic> keywords) async {
    try {
      final response = await remoteDataSource.getHomeProduct(keywords);
      return Right(response);
    } on HttpException catch (e) {
      return Left(HomeFailure(title: 'Lỗi tải sản phẩm', message: e.description ?? 'Lỗi tải sản phẩm'));
    } catch (e) {
      return Left(HomeFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<HomeFailure, CollectionListEntity>> getCollectionList() async {
    try {
      final response = await remoteDataSource.getCollectionList();
      return Right(response);
    } on HttpException catch (e) {
      return Left(HomeFailure(title: 'Lỗi tải danh sách bộ sưu tập', message: e.description ?? 'Lỗi tải danh sách bộ sưu tập'));
    } catch (e) {
      return Left(HomeFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }
}
