import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';

class CancelCartUseCase extends UseCase<void, NoParams> {
  final CartRepository _cartRepository;

  CancelCartUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _cartRepository.cancelCart();
  }
}
