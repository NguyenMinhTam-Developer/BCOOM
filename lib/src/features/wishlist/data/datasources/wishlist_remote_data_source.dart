import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/paginated_wishlist_product_list_entity.dart';
import '../models/paginated_wishlist_product_list_model.dart';

abstract class WishlistRemoteDataSource {
  Future<PaginatedWishlistProductListEntity> getWishlist({
    required int offset,
    required int limit,
  });

  Future<int> addProductsToWishlist({
    required List<int> productIds,
  });

  Future<int> removeProductsFromWishlist({
    required List<int> productIds,
  });
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  WishlistRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<PaginatedWishlistProductListEntity> getWishlist({
    required int offset,
    required int limit,
  }) async {
    final response = await _authorizedClient.get(
      '/api/products/wishlist',
      query: {
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );

    RemoteDataSource.handleResponse(response);

    return PaginatedWishlistProductListModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<int> addProductsToWishlist({
    required List<int> productIds,
  }) async {
    final response = await _authorizedClient.post(
      '/api/products/wishlist',
      {
        'product_id': productIds,
      },
    );

    RemoteDataSource.handleResponse(response);

    return (response.body['data'] as num?)?.toInt() ?? 0;
  }

  @override
  Future<int> removeProductsFromWishlist({
    required List<int> productIds,
  }) async {
    // GetConnect's delete() doesn't support body in all versions,
    // so we use request() to send DELETE with JSON body.
    final response = await _authorizedClient.request(
      '/api/products/wishlist',
      'DELETE',
      body: {
        'product_id': productIds,
      },
    );

    RemoteDataSource.handleResponse(response);

    return (response.body['data'] as num?)?.toInt() ?? 0;
  }
}

