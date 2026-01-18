import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../../home/domain/entities/collection_list_entity.dart';
import '../../../home/data/models/collection_list_model.dart';
import '../../../product_detail/data/models/paginated_product_list_model.dart';
import '../../../product_detail/domain/entities/paginated_product_list_entity.dart';
import '../../domain/entities/product_side_bar_entity.dart';
import '../../domain/entities/product_sub_side_bar_entity.dart';
import '../models/product_side_bar_model.dart';
import '../models/product_sub_side_bar_model.dart';

abstract class CatalogRemoteDataSource {
  Future<ProductSideBarEntity> getProductSideBar({
    required String slug,
    required String type,
    String? name,
  });

  Future<ProductSubSideBarEntity> getProductSubSideBar({
    required String slug,
    required String type,
    String? name,
  });

  Future<CollectionListEntity> getCollectionList();

  Future<PaginatedProductListEntity> getProductList({
    required String slug,
    required String collectionSlug,
    int? brandId,
    List<int>? priceIds,
    List<int>? filterIds,
    int? categoryId,
    required int offset,
    required int limit,
  });
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  CatalogRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<ProductSideBarEntity> getProductSideBar({
    required String slug,
    required String type,
    String? name,
  }) async {
    final queryParams = <String, String>{
      'type': type,
    };

    if (name != null) {
      queryParams['name'] = name;
    }

    final response = await _unauthorizedClient.get(
      '/api/products/sidebar/$slug',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    return ProductSideBarEntityModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ProductSubSideBarEntity> getProductSubSideBar({
    required String slug,
    required String type,
    String? name,
  }) async {
    final queryParams = <String, String>{
      'type': type,
    };

    if (name != null) {
      queryParams['name'] = name;
    }

    final response = await _unauthorizedClient.get(
      '/api/products/sidebar/$slug',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    return ProductSubSideBarEntityModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CollectionListEntity> getCollectionList() async {
    final response = await _unauthorizedClient.get(
      '/api/product-collections',
    );

    RemoteDataSource.handleResponse(response);

    return CollectionListModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<PaginatedProductListEntity> getProductList({
    required String slug,
    required String collectionSlug,
    int? brandId,
    List<int>? priceIds,
    List<int>? filterIds,
    int? categoryId,
    required int offset,
    required int limit,
  }) async {
    final queryParams = <String, String>{
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (brandId != null) {
      queryParams['brand_id'] = brandId.toString();
    }

    if (priceIds != null && priceIds.isNotEmpty) {
      queryParams['price_ids'] = priceIds.join(',');
    }

    if (filterIds != null && filterIds.isNotEmpty) {
      queryParams['filter_ids'] = filterIds.join(',');
    }

    if (categoryId != null) {
      queryParams['category_id'] = categoryId.toString();
    }

    final response = await _unauthorizedClient.get(
      '/api/products/category/$slug/$collectionSlug',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    return PaginatedProductListModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }
}
