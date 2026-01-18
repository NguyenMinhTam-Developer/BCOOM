import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/paginated_wishlist_product_list_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<WishlistFailure, PaginatedWishlistProductListEntity>> getWishlist({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getWishlist(offset: offset, limit: limit);
      return Right(response);
    } on HttpException catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi tải danh sách yêu thích',
          message: e.description ?? 'Lỗi tải danh sách yêu thích',
        ),
      );
    } catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi không xác định',
          message: 'Lỗi không xác định',
        ),
      );
    }
  }

  @override
  Future<Either<WishlistFailure, int>> addProductsToWishlist({
    required List<int> productIds,
  }) async {
    try {
      final response = await remoteDataSource.addProductsToWishlist(productIds: productIds);
      return Right(response);
    } on HttpException catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi thêm sản phẩm yêu thích',
          message: e.description ?? 'Lỗi thêm sản phẩm yêu thích',
        ),
      );
    } catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi không xác định',
          message: 'Lỗi không xác định',
        ),
      );
    }
  }

  @override
  Future<Either<WishlistFailure, int>> removeProductsFromWishlist({
    required List<int> productIds,
  }) async {
    try {
      final response = await remoteDataSource.removeProductsFromWishlist(productIds: productIds);
      return Right(response);
    } on HttpException catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi xóa sản phẩm yêu thích',
          message: e.description ?? 'Lỗi xóa sản phẩm yêu thích',
        ),
      );
    } catch (e) {
      return Left(
        WishlistFailure(
          title: 'Lỗi không xác định',
          message: 'Lỗi không xác định',
        ),
      );
    }
  }
}

