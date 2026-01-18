import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';

import '../entities/order_detail_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderStatus>>> getOrderStatus();

  Future<Either<Failure, PaginatedOrderListEntity>> getOrderList({
    required int? offset,
    required int? limit,
    String? statusCode,
  });

  Future<Either<Failure, OrderDetailEntity>> getOrderDetail({
    required int orderId,
  });
}
