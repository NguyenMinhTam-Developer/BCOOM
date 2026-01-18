import '../../../../core/services/remote_datasrouce.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/entities/related_products_entity.dart';
import '../models/product_detail_model.dart';
import '../models/related_products_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailEntity> getProductDetail({
    required String nameSlug,
  });

  Future<RelatedProductsEntity> getRelatedProducts({
    required String nameSlug,
  });
}

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  ProductDetailRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<ProductDetailEntity> getProductDetail({
    required String nameSlug,
  }) async {
    final response = await _unauthorizedClient.get(
      '/api/products/$nameSlug',
    );

    RemoteDataSource.handleResponse(response);

    // The API returns { status, description, data: { object: {...} } }
    // We need to extract the 'object' from 'data'
    final data = response.body['data'] as Map<String, dynamic>;
    final object = data['object'] as Map<String, dynamic>;

    return ProductDetailModel.fromJson(object);
  }

  @override
  Future<RelatedProductsEntity> getRelatedProducts({
    required String nameSlug,
  }) async {
    final response = await _unauthorizedClient.get(
      '/api/products/related/$nameSlug',
    );

    RemoteDataSource.handleResponse(response);

    // The API returns { status, description, data: { brand: {...}, category: {...}, seller: {...} } }
    final data = response.body['data'] as Map<String, dynamic>;

    return RelatedProductsModel.fromJson(data);
  }
}
