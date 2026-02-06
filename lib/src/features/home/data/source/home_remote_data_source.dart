import 'package:bcoom/src/core/services/remote_datasrouce.dart';
import 'package:logger/web.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../domain/entities/brand_list_entity.dart';
import '../../domain/entities/collection_list_entity.dart';
import '../../domain/entities/landing_page_entity.dart';
import '../models/brand_list_model.dart';
import '../models/collection_list_model.dart';
import '../models/landing_page_model.dart';

abstract class HomeRemoteDataSource {
  Future<LandingPageEntity> getLandingPage();
  Future<Map<String, dynamic>> getRawLandingPage();
  Future<BrandListEntity> getBrandList({
    required num? categoryId,
    required num? limit,
    required num? offset,
    required num? page,
    required String? search,
    required String? sort,
  });
  Future<Map<String, dynamic>> getHomeProduct(String keywords);
  Future<CollectionListEntity> getCollectionList();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  HomeRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<LandingPageEntity> getLandingPage() async {
    final response = await _unauthorizedClient.get(
      '/api/home/get-landing-page-position/1',
    );

    RemoteDataSource.handleResponse(response);

    return LandingPageModel.fromJson(response.body['data'] as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getRawLandingPage() async {
    final response = await _unauthorizedClient.get(
      '/api/home/get-landing-page-position/1',
    );

    RemoteDataSource.handleResponse(response);

    return response.body['data']['positions'] as Map<String, dynamic>;
  }

  @override
  Future<BrandListEntity> getBrandList({
    required num? categoryId,
    required num? limit,
    required num? offset,
    required num? page,
    required String? search,
    required String? sort,
  }) async {
    final response = await _unauthorizedClient.get(
      '/api/brands',
      query: {
        if (categoryId != null) 'category_id': categoryId.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (offset != null) 'offset': offset.toString(),
        if (page != null) 'page': page.toString(),
        if (search != null) 'search': search.toString(),
        if (sort != null) 'sort': sort.toString(),
      },
    );

    RemoteDataSource.handleResponse(response);

    return BrandListModel.fromJson(response.body['data'] as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getHomeProduct(String keywords) async {
    final response = await _unauthorizedClient.get(
      "/api/products/home?$keywords",
    );

    RemoteDataSource.handleResponse(response);

    return response.body['data'] as Map<String, dynamic>;
  }

  @override
  Future<CollectionListEntity> getCollectionList() async {
    final response = await _unauthorizedClient.get(
      '/api/product-collections',
    );

    RemoteDataSource.handleResponse(response);

    return CollectionListModel.fromJson(response.body['data'] as Map<String, dynamic>);
  }
}
