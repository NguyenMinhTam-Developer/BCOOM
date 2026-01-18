import 'api_response_entity.dart';

class ApiResponseModel<T, E> extends ApiResponseEntity<E> {
  const ApiResponseModel({
    required super.status,
    required super.description,
    required super.data,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    E Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponseModel<T, E>(
      status: json['status'] as String,
      description: json['description'] as String,
      data: fromJsonT(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(E) toJsonT) {
    return {
      'status': status,
      'description': description,
      'data': toJsonT(data),
    };
  }
}
