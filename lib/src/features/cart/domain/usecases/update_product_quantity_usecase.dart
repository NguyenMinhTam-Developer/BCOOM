import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateProductQuantityParams {
  final int productId;
  final int variantId;
  final int quantity;

  const UpdateProductQuantityParams({
    required this.productId,
    required this.variantId,
    required this.quantity,
  });
}

class UpdateProductQuantityUseCase extends UseCase<CartInfoEntity, UpdateProductQuantityParams> {
  final CartRepository _cartRepository;

  UpdateProductQuantityUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(UpdateProductQuantityParams params) async {
    return await _cartRepository.updateProductQuantity(
      productId: params.productId,
      variantId: params.variantId,
      quantity: params.quantity,
    );
  }
}
