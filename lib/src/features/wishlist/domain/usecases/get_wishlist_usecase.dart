import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/paginated_wishlist_product_list_entity.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistParams {
  final int offset;
  final int limit;

  const GetWishlistParams({
    required this.offset,
    required this.limit,
  });
}

class GetWishlistUseCase extends UseCase<PaginatedWishlistProductListEntity, GetWishlistParams> {
  final WishlistRepository _wishlistRepository;

  GetWishlistUseCase({
    required WishlistRepository wishlistRepository,
  }) : _wishlistRepository = wishlistRepository;

  @override
  Future<Either<Failure, PaginatedWishlistProductListEntity>> call(GetWishlistParams params) async {
    return await _wishlistRepository.getWishlist(
      offset: params.offset,
      limit: params.limit,
    );
  }
}

