import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/coupon_entity.dart';
import '../repositories/cart_repository.dart';

class GetSellerCouponsParams {
  final int sellerId;
  final int totalProduct;
  final List<int> productIds;

  const GetSellerCouponsParams({
    required this.sellerId,
    required this.totalProduct,
    required this.productIds,
  });
}

class GetSellerCouponsUseCase extends UseCase<SellerCouponsEntity, GetSellerCouponsParams> {
  final CartRepository _cartRepository;

  GetSellerCouponsUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, SellerCouponsEntity>> call(GetSellerCouponsParams params) async {
    return await _cartRepository.getSellerCoupons(
      sellerId: params.sellerId,
      totalProduct: params.totalProduct,
      productIds: params.productIds,
    );
  }
}
