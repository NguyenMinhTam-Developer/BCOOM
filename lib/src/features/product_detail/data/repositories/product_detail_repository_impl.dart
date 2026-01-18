import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/entities/related_products_entity.dart';
import '../../domain/repositories/product_detail_repository.dart';
import '../source/product_detail_remote_data_source.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource remoteDataSource;

  ProductDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ProductDetailFailure, ProductDetailEntity>> getProductDetail({
    required String nameSlug,
  }) async {
    try {
      final response = await remoteDataSource.getProductDetail(
        nameSlug: nameSlug,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(ProductDetailFailure(
        title: 'Lỗi tải chi tiết sản phẩm',
        message: e.description ?? 'Lỗi tải chi tiết sản phẩm',
      ));
    } catch (e) {
      return Left(ProductDetailFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<ProductDetailFailure, RelatedProductsEntity>> getRelatedProducts({
    required String nameSlug,
  }) async {
    try {
      final response = await remoteDataSource.getRelatedProducts(
        nameSlug: nameSlug,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(ProductDetailFailure(
        title: 'Lỗi tải sản phẩm liên quan',
        message: e.description ?? 'Lỗi tải sản phẩm liên quan',
      ));
    } catch (e) {
      return Left(ProductDetailFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}

