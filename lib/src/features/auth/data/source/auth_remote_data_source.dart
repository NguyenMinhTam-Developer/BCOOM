import '../../../../core/services/remote_datasrouce.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/my_point_history.dart';
import '../../domain/entities/my_gifts.dart';
import '../../domain/entities/my_course.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import '../models/my_point_history_model.dart';
import '../models/my_gifts_model.dart';
import '../models/my_course_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> loginWithEmail({required String email, required String password});

  Future<AuthResponseModel> loginWithPhone({required String phoneNumber, required String password});

  Future<AuthResponseModel> loginWithIdBcoom({required String bcoomId, required String password});

  Future<AuthResponseModel> register({required String email, required String phone, required String password, required String passwordConfirmation});

  Future<AuthResponseModel> registerCooperation({
    required String customerType,
    required String fullName,
    required String phone,
    required String email,
    required String provinceCode,
    required String job,
    required String note,
  });

  Future<void> updateProfile({
    required String? avatar,
    required String fullName,
    required String dateOfBirth,
    required String? gender,
    required int? countryId,
    required String? identityCardImageFront,
    required String? identityCardImageBack,
  });

  Future<DateTime> sendVerificationNotification();

  Future<void> sendVerificationNotificationWithToken({required String token});

  Future<UserEntity> verifyOtp({required num otp});

  Future<UserEntity> getProfile();

  Future<String> sendResetPasswordRequestByEmail({required String email});

  Future<void> resetPassword({required String otp, required String token, required String password, required String passwordConfirmation});

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  });

  Future<MyPointHistoryPaginationEntity> getMyPointHistory({
    required int offset,
    required int limit,
    String? search,
    String? sort,
    PointHistoryType? type,
  });

  Future<List<MyGiftsEntity>> getMyGifts({
    GiftStatus? status,
  });

  Future<MyCoursePaginationEntity> getMyCourse({
    int? isCompleted,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;
  final AuthorizedClient _authorizedClient;

  AuthRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
    required AuthorizedClient authorizedClient,
  })  : _unauthorizedClient = unauthorizedClient,
        _authorizedClient = authorizedClient;

  @override
  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/login',
      {
        'username': email,
        'password': password,
      },
    );

    RemoteDataSource.handleResponse(response);

    var authResponse = AuthResponseModel.fromJson(response.body);

    if (authResponse.data.user.emailVerifiedAt == null) {
      throw EmailNotVerifiedException(
        description: 'Email chưa được xác thực',
        authResponse: authResponse,
      );
    }

    return authResponse;
  }

  @override
  Future<AuthResponseModel> loginWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/login',
      {
        'username': phoneNumber,
        'password': password,
      },
    );

    RemoteDataSource.handleResponse(response);

    var authResponse = AuthResponseModel.fromJson(response.body);

    if (authResponse.data.user.emailVerifiedAt == null) {
      throw EmailNotVerifiedException(
        description: 'Email chưa được xác thực',
        authResponse: authResponse,
      );
    }

    return AuthResponseModel.fromJson(response.body);
  }

  @override
  Future<AuthResponseModel> loginWithIdBcoom({required String bcoomId, required String password}) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/login',
      {
        'username': bcoomId,
        'password': password,
      },
    );

    RemoteDataSource.handleResponse(response);

    var authResponse = AuthResponseModel.fromJson(response.body);

    if (authResponse.data.user.emailVerifiedAt == null) {
      throw EmailNotVerifiedException(
        description: 'Email chưa được xác thực',
        authResponse: authResponse,
      );
    }

    return AuthResponseModel.fromJson(response.body);
  }

  @override
  Future<AuthResponseModel> register({
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/register',
      {
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    RemoteDataSource.handleResponse(response);

    return AuthResponseModel.fromJson(response.body);
  }

  @override
  Future<AuthResponseModel> registerCooperation({
    required String customerType,
    required String fullName,
    required String phone,
    required String email,
    required String provinceCode,
    required String job,
    required String note,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/register-cooperation',
      {
        'customer_type': customerType,
        'full_name': fullName,
        'phone': phone,
        'email': email,
        'province_code': provinceCode,
        'job': job,
        'note': note,
      },
    );

    RemoteDataSource.handleResponse(response);

    return AuthResponseModel.fromJson(response.body);
  }

  @override
  Future<DateTime> sendVerificationNotification() async {
    final response = await _authorizedClient.post(
      '/api/customers/auth/verification-notification',
      null,
    );

    RemoteDataSource.handleResponse(response);

    return DateTime.parse(response.body['data']['otp_expire']);
  }

  @override
  Future<void> sendVerificationNotificationWithToken({required String token}) async {
    await _unauthorizedClient.post(
      '/api/customers/auth/verification-notification',
      null,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // RemoteDataSource.handleResponse(response);
  }

  @override
  Future<UserEntity> verifyOtp({required num otp}) async {
    final response = await _authorizedClient.post(
      '/api/customers/auth/verify',
      {
        'otp': otp,
      },
    );

    RemoteDataSource.handleResponse(response);

    return UserModel.fromJson(response.body['data']);
  }

  @override
  Future<void> updateProfile({
    required String? avatar,
    required String fullName,
    required String dateOfBirth,
    required String? gender,
    required int? countryId,
    required String? identityCardImageFront,
    required String? identityCardImageBack,
  }) async {
    final response = await _authorizedClient.put(
      '/api/customers/auth/update-profile',
      {
        if (avatar != null) "avatar": avatar,
        "full_name": fullName,
        "date_of_birth": dateOfBirth,
        if (gender != null) "gender": gender,
        if (countryId != null) "country_id": countryId,
        if (identityCardImageFront != null) "identity_card_image_front": identityCardImageFront,
        if (identityCardImageBack != null) "identity_card_image_back": identityCardImageBack,
      },
    );

    RemoteDataSource.handleResponse(response);
  }

  @override
  Future<UserEntity> getProfile() async {
    final response = await _authorizedClient.post('/api/customers/auth/me', null);

    RemoteDataSource.handleResponse(response);

    return UserModel.fromJson(response.body['data']);
  }

  @override
  Future<String> sendResetPasswordRequestByEmail({required String email}) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/forgot-password',
      {
        'phone': email,
      },
    );

    RemoteDataSource.handleResponse(response);

    return response.body['data']?['token'] ?? '';
  }

  @override
  Future<void> resetPassword({
    required String otp,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/customers/auth/reset-password',
      {
        'otp': otp,
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    RemoteDataSource.handleResponse(response);
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/auth/change-password',
      {
        'password_old': oldPassword,
        'password_new': newPassword,
        'password_confirm': passwordConfirmation,
      },
    );

    RemoteDataSource.handleResponse(response);
  }

  @override
  Future<MyPointHistoryPaginationEntity> getMyPointHistory({
    required int offset,
    required int limit,
    String? search,
    String? sort,
    PointHistoryType? type,
  }) async {
    final Map<String, dynamic> queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
      if (sort != null && sort.isNotEmpty) 'sort': sort,
      if (type != null) 'type': type.toStringValue(),
    };

    final response = await _authorizedClient.get(
      '/api/customers/point-history/me',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    return MyPointHistoryPaginationModel.fromJson(response.body['data']);
  }

  @override
  Future<List<MyGiftsEntity>> getMyGifts({
    GiftStatus? status,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (status != null) 'status': status.toStringValue(),
    };

    final response = await _authorizedClient.get(
      '/api/customers/voucher/me',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    final List<dynamic> data = response.body['data'] ?? [];
    return data.map((json) => MyGiftsModel.fromJson(json)).toList();
  }

  @override
  Future<MyCoursePaginationEntity> getMyCourse({
    int? isCompleted,
  }) async {
    final Map<String, dynamic> queryParams = {
      if (isCompleted != null) 'is_completed': isCompleted.toString(),
    };

    final response = await _authorizedClient.get(
      '/api/customers/course-user/me',
      query: queryParams,
    );

    RemoteDataSource.handleResponse(response);

    if (isCompleted == null) {
      return MyCoursePaginationModel(
        rows: [],
        more: false,
        limit: 0,
        total: 0,
      );
    }

    return MyCoursePaginationModel.fromJson(response.body['data']);
  }
}
