import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_detail_entity.dart';
import '../models/order_model.dart';
import '../models/order_detail_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderStatus>> getOrderStatus();

  Future<PaginatedOrderListEntity> getOrderList({
    required int? offset,
    required int? limit,
    String? statusCode,
  });

  Future<OrderDetailEntity> getOrderDetail({
    required int orderId,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  OrderRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<List<OrderStatus>> getOrderStatus() async {
    final response = await _authorizedClient.get(
      '/api/customers/orders',
    );

    RemoteDataSource.handleResponse(response);

    final data = response.body['data'] as Map<String, dynamic>;
    final statusList = data['number_orders_by_status'] as List<dynamic>;

    return statusList.map((e) => OrderStatusModel.fromJson(
      e as Map<String, dynamic>,
    )).toList();
  }

  @override
  Future<PaginatedOrderListEntity> getOrderList({
    required int? offset,
    required int? limit,
    String? statusCode,
  }) async {
    final query = <String, String>{};
    
    if (offset != null) {
      query['offset'] = offset.toString();
    }
    
    if (limit != null) {
      query['limit'] = limit.toString();
    }
    
    if (statusCode != null && statusCode.isNotEmpty) {
      query['status_code'] = statusCode;
    }

    final response = await _authorizedClient.get(
      '/api/customers/orders',
      query: query,
    );

    RemoteDataSource.handleResponse(response);

    final data = response.body['data'] as Map<String, dynamic>;
    final ordersData = data['orders'] as Map<String, dynamic>;

    return PaginatedOrderListModel.fromJson(ordersData);
  }

  @override
  Future<OrderDetailEntity> getOrderDetail({
    required int orderId,
  }) async {
    final response = await _authorizedClient.get(
      '/api/customers/orders/$orderId',
    );

    RemoteDataSource.handleResponse(response);

    final data = response.body['data'] as Map<String, dynamic>;

    return OrderDetailModel.fromJson(data);
  }
}
