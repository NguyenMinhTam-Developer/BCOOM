import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_detail_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';

class OrderFailure extends Failure {
  const OrderFailure({
    required super.title,
    required super.message,
  });
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OrderStatus>>> getOrderStatus() async {
    try {
      final response = await remoteDataSource.getOrderStatus();
      return Right(response);
    } on HttpException catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi tải trạng thái đơn hàng',
        message: e.description ?? 'Lỗi tải trạng thái đơn hàng',
      ));
    } catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, PaginatedOrderListEntity>> getOrderList({
    required int? offset,
    required int? limit,
    String? statusCode,
  }) async {
    try {
      final response = await remoteDataSource.getOrderList(
        offset: offset,
        limit: limit,
        statusCode: statusCode,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi tải danh sách đơn hàng',
        message: e.description ?? 'Lỗi tải danh sách đơn hàng',
      ));
    } catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, OrderDetailEntity>> getOrderDetail({
    required int orderId,
  }) async {
    try {
      final response = await remoteDataSource.getOrderDetail(orderId: orderId);
      return Right(response);
    } on HttpException catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi tải chi tiết đơn hàng',
        message: e.description ?? 'Lỗi tải chi tiết đơn hàng',
      ));
    } catch (e) {
      return Left(OrderFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
