import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/paginated_wishlist_product_list_entity.dart';

abstract class WishlistRepository {
  Future<Either<WishlistFailure, PaginatedWishlistProductListEntity>> getWishlist({
    required int offset,
    required int limit,
  });

  Future<Either<WishlistFailure, int>> addProductsToWishlist({
    required List<int> productIds,
  });

  Future<Either<WishlistFailure, int>> removeProductsFromWishlist({
    required List<int> productIds,
  });
}

