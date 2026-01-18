import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class SelectShippingAddressParams {
  final int addressId;

  const SelectShippingAddressParams({
    required this.addressId,
  });
}

class SelectShippingAddressUseCase extends UseCase<CartInfoEntity, SelectShippingAddressParams> {
  final CartRepository _cartRepository;

  SelectShippingAddressUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(SelectShippingAddressParams params) async {
    return await _cartRepository.selectShippingAddress(
      addressId: params.addressId,
    );
  }
}
