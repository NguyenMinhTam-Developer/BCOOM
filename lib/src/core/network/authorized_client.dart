import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../flavors.dart';
import '../services/local_storage_service.dart';

const turnOnDebugLoggging = true;
const turnOnApiParamLoggging = false;

class AuthorizedClient extends GetConnect {
  final LocalStorageService _localStorageService;

  final Logger _logger = Logger();

  AuthorizedClient({
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService,
        super();

  @override
  void onInit() {
    httpClient.baseUrl = F.baseUrl;

    httpClient.addRequestModifier<void>((request) async {
      request.headers['Authorization'] = 'Bearer ${_localStorageService.readData<String>('auth_token')}';

      _logger.i({
        request.method.toUpperCase(): request.url,
        // 'headers': request.headers,
      });

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      _logger.i({
        'statusCode': response.statusCode,
        request.method.toUpperCase(): request.url,
        'body': response.body,
      });

      return response;
    });
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _logger.i({
      'url': url,
      'headers': headers,
      'body': body,
    });

    return super.post(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }
}
