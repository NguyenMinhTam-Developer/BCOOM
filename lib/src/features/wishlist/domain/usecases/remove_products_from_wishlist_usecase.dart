import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/wishlist_repository.dart';

class RemoveProductsFromWishlistParams {
  final List<int> productIds;

  const RemoveProductsFromWishlistParams({
    required this.productIds,
  });
}

class RemoveProductsFromWishlistUseCase extends UseCase<int, RemoveProductsFromWishlistParams> {
  final WishlistRepository _wishlistRepository;

  RemoveProductsFromWishlistUseCase({
    required WishlistRepository wishlistRepository,
  }) : _wishlistRepository = wishlistRepository;

  @override
  Future<Either<Failure, int>> call(RemoveProductsFromWishlistParams params) async {
    return await _wishlistRepository.removeProductsFromWishlist(
      productIds: params.productIds,
    );
  }
}

