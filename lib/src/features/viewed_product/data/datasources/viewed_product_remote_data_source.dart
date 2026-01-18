import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/paginated_viewed_product_list_entity.dart';
import '../models/paginated_viewed_product_list_model.dart';

abstract class ViewedProductRemoteDataSource {
  Future<PaginatedViewedProductListEntity> getViewedProducts({
    required int offset,
    required int limit,
  });
}

class ViewedProductRemoteDataSourceImpl implements ViewedProductRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  ViewedProductRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<PaginatedViewedProductListEntity> getViewedProducts({
    required int offset,
    required int limit,
  }) async {
    final response = await _authorizedClient.get(
      '/api/products/viewed',
      query: {
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );

    RemoteDataSource.handleResponse(response);

    return PaginatedViewedProductListModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }
}

