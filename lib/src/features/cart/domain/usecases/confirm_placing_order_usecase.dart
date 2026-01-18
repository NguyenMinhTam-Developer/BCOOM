import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order_entity.dart';
import '../repositories/cart_repository.dart';

class ConfirmPlacingOrderParams {
  final List<Map<String, int>> products;
  final String? remarks;
  final int hasExportEinvoice;
  final String paymentMethod;
  final Map<String, String> shippingAddress;
  final dynamic einvoice;

  const ConfirmPlacingOrderParams({
    required this.products,
    this.remarks,
    this.hasExportEinvoice = 0,
    required this.paymentMethod,
    required this.shippingAddress,
    this.einvoice,
  });
}

class ConfirmPlacingOrderUseCase extends UseCase<CartOrderEntity, ConfirmPlacingOrderParams> {
  final CartRepository _cartRepository;

  ConfirmPlacingOrderUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartOrderEntity>> call(ConfirmPlacingOrderParams params) async {
    return await _cartRepository.confirmPlacingOrder(
      products: params.products,
      remarks: params.remarks,
      hasExportEinvoice: params.hasExportEinvoice,
      paymentMethod: params.paymentMethod,
      shippingAddress: params.shippingAddress,
      einvoice: params.einvoice,
    );
  }
}
