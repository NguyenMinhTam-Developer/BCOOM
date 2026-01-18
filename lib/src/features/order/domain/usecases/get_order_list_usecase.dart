import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderListParams {
  final int? offset;
  final int? limit;
  final String? statusCode;

  const GetOrderListParams({
    this.offset,
    this.limit,
    this.statusCode,
  });
}

class GetOrderListUseCase extends UseCase<PaginatedOrderListEntity, GetOrderListParams> {
  final OrderRepository _orderRepository;

  GetOrderListUseCase({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, PaginatedOrderListEntity>> call(GetOrderListParams params) async {
    return await _orderRepository.getOrderList(
      offset: params.offset,
      limit: params.limit,
      statusCode: params.statusCode,
    );
  }
}
