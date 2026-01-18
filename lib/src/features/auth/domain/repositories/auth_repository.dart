import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_response.dart';
import '../entities/user.dart';
import '../entities/my_point_history.dart';
import '../entities/my_gifts.dart';
import '../entities/my_course.dart';

abstract class AuthRepository {
  /// Login with email and password
  Future<Either<AuthFailure, AuthResponse>> loginWithEmail({
    required String email,
    required String password,
  });

  /// Login with phone number and password
  Future<Either<AuthFailure, AuthResponse>> loginWithPhone({
    required String phoneNumber,
    required String password,
  });

  /// Login with phone number and password
  Future<Either<AuthFailure, AuthResponse>> loginWithIdBcoom({
    required String bcoomId,
    required String password,
  });

  /// Register with email and password
  Future<Either<AuthFailure, AuthResponse>> register({
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
  });

  /// Register cooperation (collaborator or agent)
  Future<Either<AuthFailure, AuthResponse>> registerCooperation({
    required String customerType,
    required String fullName,
    required String phone,
    required String email,
    required String provinceCode,
    required String job,
    required String note,
  });

  /// Update profile
  Future<Either<AuthFailure, UserEntity>> updateProfile({
    required String? avatar,
    required String fullName,
    required DateTime dateOfBirth,
    required String? gender,
    required int? countryId,
    required String? identityCardImageFront,
    required String? identityCardImageBack,
  });

  Future<Either<AuthFailure, UserEntity>> getProfile();

  Future<Either<AuthFailure, DateTime>> sendVerificationNotification();

  Future<Either<AuthFailure, UserEntity>> verifyOtp({required num otp});

  // Return a token to reset password
  Future<Either<AuthFailure, String>> sendResetPasswordRequestByEmail({required String email});

  Future<Either<AuthFailure, void>> resetPassword({required String otp, required String token, required String password, required String passwordConfirmation});

  /// Change password
  Future<Either<AuthFailure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  });

  /// Get my point history with pagination
  Future<Either<AuthFailure, MyPointHistoryPaginationEntity>> getMyPointHistory({
    required int offset,
    required int limit,
    String? search,
    String? sort,
    PointHistoryType? type,
  });

  /// Get my gifts
  Future<Either<AuthFailure, List<MyGiftsEntity>>> getMyGifts({
    GiftStatus? status,
  });

  /// Get my courses
  Future<Either<AuthFailure, MyCoursePaginationEntity>> getMyCourse({
    int? isCompleted,
  });
}
