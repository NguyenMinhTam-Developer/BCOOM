import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/wishlist_repository.dart';

class AddProductsToWishlistParams {
  final List<int> productIds;

  const AddProductsToWishlistParams({
    required this.productIds,
  });
}

class AddProductsToWishlistUseCase extends UseCase<int, AddProductsToWishlistParams> {
  final WishlistRepository _wishlistRepository;

  AddProductsToWishlistUseCase({
    required WishlistRepository wishlistRepository,
  }) : _wishlistRepository = wishlistRepository;

  @override
  Future<Either<Failure, int>> call(AddProductsToWishlistParams params) async {
    return await _wishlistRepository.addProductsToWishlist(
      productIds: params.productIds,
    );
  }
}

