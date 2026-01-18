import '../errors/exception.dart';
import 'package:get/get.dart';

class RemoteDataSource {
  static handleResponse(Response<dynamic> response) {
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

  static String? extractErrorMessage(dynamic response) {
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
}
