import '../../features/auth/domain/entities/auth_response.dart';

class HttpException implements Exception {
  final int? statusCode;
  final String? status;
  final String? description;
  final dynamic data;

  HttpException({
    required this.statusCode,
    required this.status,
    this.description,
    this.data,
  });
}

class EmailNotVerifiedException implements Exception {
  final String? description;
  final AuthResponse authResponse;

  EmailNotVerifiedException({
    required this.description,
    required this.authResponse,
  });
}

class UnknownException implements Exception {
  final Object exception;

  UnknownException({
    required this.exception,
  });
}
