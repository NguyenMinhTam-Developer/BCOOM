import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class AddProductToCartParams {
  final int productId;
  final int variantId;
  final int quantity;

  const AddProductToCartParams({
    required this.productId,
    this.variantId = 0,
    required this.quantity,
  });
}

class AddProductToCartUseCase extends UseCase<CartInfoEntity, AddProductToCartParams> {
  final CartRepository _cartRepository;

  AddProductToCartUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(AddProductToCartParams params) async {
    return await _cartRepository.addProductToCart(
      productId: params.productId,
      variantId: params.variantId,
      quantity: params.quantity,
    );
  }
}
