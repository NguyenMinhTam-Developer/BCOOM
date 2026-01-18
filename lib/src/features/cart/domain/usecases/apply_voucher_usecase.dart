import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_info_entity.dart';
import '../repositories/cart_repository.dart';

class ApplyVoucherParams {
  final String voucherCode;

  const ApplyVoucherParams({
    required this.voucherCode,
  });
}

class ApplyVoucherUseCase extends UseCase<CartInfoEntity, ApplyVoucherParams> {
  final CartRepository _cartRepository;

  ApplyVoucherUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartInfoEntity>> call(ApplyVoucherParams params) async {
    return await _cartRepository.applyVoucher(
      voucherCode: params.voucherCode,
    );
  }
}
