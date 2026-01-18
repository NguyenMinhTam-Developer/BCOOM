import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order_detail_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailParams {
  final int orderId;

  const GetOrderDetailParams({
    required this.orderId,
  });
}

class GetOrderDetailUseCase extends UseCase<OrderDetailEntity, GetOrderDetailParams> {
  final OrderRepository _orderRepository;

  GetOrderDetailUseCase({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, OrderDetailEntity>> call(GetOrderDetailParams params) async {
    return await _orderRepository.getOrderDetail(orderId: params.orderId);
  }
}
