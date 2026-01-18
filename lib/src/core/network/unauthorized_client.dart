import 'package:get/get_connect.dart';
import 'package:logger/logger.dart';

import '../../../flavors.dart';

class UnauthorizedClient extends GetConnect {
  final Logger _logger = Logger();

  UnauthorizedClient() : super();

  @override
  void onInit() {
    httpClient.baseUrl = F.baseUrl;

    httpClient.addResponseModifier((request, response) {
      _logger.i({
        'statusCode': response.statusCode,
        'url': request.url,
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
