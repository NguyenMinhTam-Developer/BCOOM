import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartParams {
  final List<Map<String, int>> products;

  const UpdateCartParams({
    required this.products,
  });
}

class UpdateCartUseCase extends UseCase<CartInfoEntity, UpdateCartParams> {
  final CartRepository _cartRepository;

  UpdateCartUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(UpdateCartParams params) async {
    return await _cartRepository.updateCart(
      products: params.products,
    );
  }
}
