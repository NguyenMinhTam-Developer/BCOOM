import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/my_keyword_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/suggestion_keyword_list_entity.dart';
import '../models/my_keyword_model.dart';
import '../models/search_result_model.dart';
import '../models/suggestion_keyword_list_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<MyKeywordEntity>> getMyKeywords();
  Future<SuggestionKeywordListEntity> getSuggestionKeywords({
    required String search,
    required int offset,
    required int limit,
  });
  Future<SearchResultEntity> search({
    required String collectionSlug,
    required String search,
    int? offset,
    int? limit,
    String? sort,
    String? order,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  SearchRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<List<MyKeywordEntity>> getMyKeywords() async {
    final response = await _authorizedClient.get(
      '/api/products/search/my-keywords',
    );

    RemoteDataSource.handleResponse(response);

    final List<dynamic> data = response.body['data'] as List<dynamic>;
    return data.map((e) => MyKeywordModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<SuggestionKeywordListEntity> getSuggestionKeywords({
    required String search,
    required int offset,
    required int limit,
  }) async {
    final response = await _authorizedClient.get(
      '/api/products/search/suggestions-keywords',
      query: {
        'search': search,
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );

    RemoteDataSource.handleResponse(response);

    return SuggestionKeywordListModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<SearchResultEntity> search({
    required String collectionSlug,
    required String search,
    int? offset,
    int? limit,
    String? sort,
    String? order,
  }) async {
    final queryParams = <String, String>{
      'search': search,
    };

    if (offset != null) {
      queryParams['offset'] = offset.toString();
    }
    if (limit != null) {
      queryParams['limit'] = limit.toString();
    }
    if (sort != null) {
      queryParams['sort'] = sort;
    }
    if (order != null) {
      queryParams['order'] = order;
    }

    final response = await _authorizedClient.get(
      '/api/products/search/$collectionSlug',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    return SearchResultModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }
}

handleResponse(Response<dynamic> response) {
  if (response.statusCode == 200 && response.body?['status'] == 'error') {
    throw HttpException(
      statusCode: response.statusCode,
      status: response.body?['status'],
      description: extractErrorMessage(response.body),
    );
  }

  if (response.statusCode == 201 && response.body?['status'] == 'error') {
    throw HttpException(
      statusCode: response.statusCode,
      status: response.body?['status'],
      description: response.body?['description'],
    );
  }

  if (response.statusCode != 200) {
    throw HttpException(
      statusCode: response.statusCode,
      status: response.body?['status'],
      description: extractErrorMessage(response.body),
    );
  }

  if (response.status.isServerError) {
    throw HttpException(
      statusCode: response.statusCode,
      status: response.body?['status'],
      description: "Đã có lỗi xảy ra, vui lòng thử lại sau",
    );
  }
}

String? extractErrorMessage(dynamic response) {
  if (response is! Map<String, dynamic>) return null;

  String status = response['status'];

  if (status == 'error') {
    Map<String, dynamic>? errors = response['data'];

    if (errors == null) {
      return response['description'];
    }

    if (errors.isNotEmpty) {
      for (final entry in errors.entries) {
        if (entry.value is List) {
          final List<dynamic> errorList = entry.value;
          if (errorList.isNotEmpty && errorList.first is String) {
            return errorList.first;
          }
        }
      }
    }

    return null;
  }

  return null;
}
