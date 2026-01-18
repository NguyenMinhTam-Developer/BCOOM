import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/collection_list_entity.dart';
import '../../../product_detail/domain/entities/paginated_product_list_entity.dart';
import '../../domain/entities/product_side_bar_entity.dart';
import '../../domain/entities/product_sub_side_bar_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/catalog_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CatalogRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductSideBarEntity>> getProductSideBar({
    required String slug,
    required String type,
    String? name,
  }) async {
    try {
      final response = await remoteDataSource.getProductSideBar(
        slug: slug,
        type: type,
        name: name,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi tải dữ liệu danh mục',
        message: e.description ?? 'Lỗi tải dữ liệu danh mục',
      ));
    } catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, ProductSubSideBarEntity>> getProductSubSideBar({
    required String slug,
    required String type,
    String? name,
  }) async {
    try {
      final response = await remoteDataSource.getProductSubSideBar(
        slug: slug,
        type: type,
        name: name,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi tải dữ liệu danh mục phụ',
        message: e.description ?? 'Lỗi tải dữ liệu danh mục phụ',
      ));
    } catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CollectionListEntity>> getCollectionList() async {
    try {
      final response = await remoteDataSource.getCollectionList();
      return Right(response);
    } on HttpException catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi tải danh sách bộ sưu tập',
        message: e.description ?? 'Lỗi tải danh sách bộ sưu tập',
      ));
    } catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, PaginatedProductListEntity>> getProductList({
    required String slug,
    required String collectionSlug,
    int? brandId,
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getProductList(
        slug: slug,
        collectionSlug: collectionSlug,
        brandId: brandId,
        offset: offset,
        limit: limit,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi tải danh sách sản phẩm',
        message: e.description ?? 'Lỗi tải danh sách sản phẩm',
      ));
    } catch (e) {
      return Left(CatalogFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
