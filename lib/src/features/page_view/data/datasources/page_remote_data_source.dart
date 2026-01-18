import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/page_entity.dart';
import '../models/page_model.dart';

abstract class PageRemoteDataSource {
  Future<PageEntity> getPage({
    required String slug,
  });
}

class PageRemoteDataSourceImpl implements PageRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  PageRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<PageEntity> getPage({
    required String slug,
  }) async {
    final response = await _unauthorizedClient.get(
      '/api/pages/$slug',
    );

    RemoteDataSource.handleResponse(response);

    return PageModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }
}
