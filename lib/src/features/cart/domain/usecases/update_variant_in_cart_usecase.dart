import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateVariantInCartParams {
  final int productId;
  final int variantId;
  final int quantity;

  const UpdateVariantInCartParams({
    required this.productId,
    required this.variantId,
    required this.quantity,
  });
}

class UpdateVariantInCartUseCase extends UseCase<CartInfoEntity, UpdateVariantInCartParams> {
  final CartRepository _cartRepository;

  UpdateVariantInCartUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(UpdateVariantInCartParams params) async {
    return await _cartRepository.updateVariantInCart(
      productId: params.productId,
      variantId: params.variantId,
      quantity: params.quantity,
    );
  }
}
