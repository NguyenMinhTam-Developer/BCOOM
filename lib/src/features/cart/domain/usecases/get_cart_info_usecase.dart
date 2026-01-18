import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartInfoUseCase extends UseCase<CartInfoEntity, NoParams> {
  final CartRepository _cartRepository;

  GetCartInfoUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(NoParams params) async {
    return await _cartRepository.getCartInfo();
  }
}
