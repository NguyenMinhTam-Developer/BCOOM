import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderStatusUseCase extends UseCase<List<OrderStatus>, NoParams> {
  final OrderRepository _orderRepository;

  GetOrderStatusUseCase({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderStatus>>> call(NoParams params) async {
    return await _orderRepository.getOrderStatus();
  }
}
