import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/paginated_viewed_product_list_entity.dart';
import '../../domain/repositories/viewed_product_repository.dart';
import '../datasources/viewed_product_remote_data_source.dart';

class ViewedProductRepositoryImpl implements ViewedProductRepository {
  final ViewedProductRemoteDataSource remoteDataSource;

  ViewedProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ViewedProductFailure, PaginatedViewedProductListEntity>> getViewedProducts({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getViewedProducts(offset: offset, limit: limit);
      return Right(response);
    } on HttpException catch (e) {
      return Left(
        ViewedProductFailure(
          title: 'Lỗi tải sản phẩm đã xem',
          message: e.description ?? 'Lỗi tải sản phẩm đã xem',
        ),
      );
    } catch (e) {
      return Left(
        ViewedProductFailure(
          title: 'Lỗi không xác định',
          message: 'Lỗi không xác định',
        ),
      );
    }
  }
}

