import 'user.dart';

class AuthResponse {
  final String status;
  final String description;
  final AuthData data;

  const AuthResponse({
    required this.status,
    required this.description,
    required this.data,
  });

  AuthResponse copyWith({
    String? status,
    String? description,
    AuthData? data,
  }) {
    return AuthResponse(
      status: status ?? this.status,
      description: description ?? this.description,
      data: data ?? this.data,
    );
  }
}

class AuthData {
  final String token;
  final UserEntity user;
  final int expiresIn;

  const AuthData({
    required this.token,
    required this.user,
    required this.expiresIn,
  });

  AuthData copyWith({
    String? token,
    UserEntity? user,
    int? expiresIn,
  }) {
    return AuthData(
      token: token ?? this.token,
      user: user ?? this.user,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
