import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/coupon_entity.dart';
import '../repositories/cart_repository.dart';

class GetPlatformCouponsUseCase extends UseCase<PlatformCouponsEntity, NoParams> {
  final CartRepository _cartRepository;

  GetPlatformCouponsUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, PlatformCouponsEntity>> call(NoParams params) async {
    return await _cartRepository.getPlatformCoupons();
  }
}
