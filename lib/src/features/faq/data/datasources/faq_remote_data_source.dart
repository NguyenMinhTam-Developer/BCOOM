import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/faq_category_list_entity.dart';
import '../../domain/entities/faq_list_entity.dart';
import '../models/faq_category_model.dart';
import '../models/faq_model.dart';

abstract class FaqRemoteDataSource {
  Future<FaqCategoryListEntity> getFaqCategories();

  Future<FaqListEntity> getFaqs({
    required int categoryId,
  });

  Future<FaqListEntity> getAllFaqs();
}

class FaqRemoteDataSourceImpl implements FaqRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  FaqRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<FaqCategoryListEntity> getFaqCategories() async {
    final response = await _unauthorizedClient.get(
      '/api/faq-categories',
      query: {
        'limit': '999',
      },
    );

    RemoteDataSource.handleResponse(response);

    return FaqCategoryListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<FaqListEntity> getFaqs({
    required int categoryId,
  }) async {
    final response = await _unauthorizedClient.get(
      '/api/faqs',
      query: {
        'category_id': categoryId.toString(),
        'limit': '999',
      },
    );

    RemoteDataSource.handleResponse(response);

    return FaqListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<FaqListEntity> getAllFaqs() async {
    final response = await _unauthorizedClient.get(
      '/api/faqs',
      query: {
        'limit': '999',
      },
    );

    RemoteDataSource.handleResponse(response);

    return FaqListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }
}
