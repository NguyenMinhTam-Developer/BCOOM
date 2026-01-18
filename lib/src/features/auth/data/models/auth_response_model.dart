import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/auth_response.dart';
import 'user_model.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.status,
    required super.description,
    required super.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      status: JsonMapperUtils.safeParseString(json['status']),
      description: JsonMapperUtils.safeParseString(json['description']),
      data: AuthDataModel.fromJson(
        JsonMapperUtils.safeParseMap(json['data']),
      ),
    );
  }
}

class AuthDataModel extends AuthData {
  const AuthDataModel({
    required super.token,
    required super.user,
    required super.expiresIn,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      token: JsonMapperUtils.safeParseString(json['token']),
      user: UserModel.fromJson(
        JsonMapperUtils.safeParseMap(json['user']),
      ),
      expiresIn: JsonMapperUtils.safeParseInt(json['expires_in']),
    );
  }
}
