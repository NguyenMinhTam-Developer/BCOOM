import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/my_point_history.dart';
import '../../domain/entities/my_gifts.dart';
import '../../domain/entities/my_course.dart';
import '../../domain/repositories/auth_repository.dart';
import '../source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AuthFailure, AuthResponse>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.loginWithEmail(
        email: email,
        password: password,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đăng nhập', message: e.description ?? 'Lỗi đăng nhập'));
    } on EmailNotVerifiedException catch (e) {
      return Left(
        EmailNotVerifiedFailure(
          title: 'Lỗi đăng nhập',
          message: e.description ?? 'Email chưa được xác thực',
          authResponse: e.authResponse,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> loginWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.loginWithPhone(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đăng nhập', message: e.description ?? 'Lỗi đăng nhập'));
    } on EmailNotVerifiedException catch (e) {
      return Left(
        EmailNotVerifiedFailure(
          title: 'Lỗi đăng nhập',
          message: e.description ?? 'Email chưa được xác thực',
          authResponse: e.authResponse,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(title: 'Lỗi đăng nhập', message: 'Lỗi đăng nhập'));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> loginWithIdBcoom({
    required String bcoomId,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.loginWithIdBcoom(
        bcoomId: bcoomId,
        password: password,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đăng nhập', message: e.description ?? 'Lỗi đăng nhập'));
    } on EmailNotVerifiedException catch (e) {
      return Left(
        EmailNotVerifiedFailure(
          title: 'Lỗi đăng nhập',
          message: e.description ?? 'Email chưa được xác thực',
          authResponse: e.authResponse,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(title: 'Lỗi đăng nhập', message: 'Lỗi đăng nhập'));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> register({
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await remoteDataSource.register(
        email: email,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đăng ký', message: e.description ?? 'Lỗi đăng ký'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> registerCooperation({
    required String customerType,
    required String fullName,
    required String phone,
    required String email,
    required String provinceCode,
    required String job,
    required String note,
  }) async {
    try {
      final response = await remoteDataSource.registerCooperation(
        customerType: customerType,
        fullName: fullName,
        phone: phone,
        email: email,
        provinceCode: provinceCode,
        job: job,
        note: note,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đăng ký', message: e.description ?? 'Lỗi đăng ký'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateProfile({
    required String? avatar,
    required String fullName,
    required DateTime dateOfBirth,
    required String? gender,
    required int? countryId,
    required String? identityCardImageFront,
    required String? identityCardImageBack,
  }) async {
    try {
      final String dob =
          '${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}';

      await remoteDataSource.updateProfile(
        avatar: avatar,
        fullName: fullName,
        dateOfBirth: dob,
        gender: gender,
        countryId: countryId,
        identityCardImageFront: identityCardImageFront,
        identityCardImageBack: identityCardImageBack,
      );

      // Update-profile may return void; refresh user from /me
      final refreshedUser = await remoteDataSource.getProfile();
      return Right(refreshedUser);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi cập nhật thông tin', message: e.description ?? 'Lỗi cập nhật thông tin'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, DateTime>> sendVerificationNotification() async {
    try {
      DateTime? dateTime = await remoteDataSource.sendVerificationNotification();
      return Right(dateTime);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi gửi mã xác thực', message: e.description ?? 'Lỗi gửi mã xác thực'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> verifyOtp({required num otp}) async {
    try {
      final response = await remoteDataSource.verifyOtp(otp: otp);
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi xác thực', message: e.description ?? 'Lỗi xác thực'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, String>> sendResetPasswordRequestByEmail({required String email}) async {
    try {
      final token = await remoteDataSource.sendResetPasswordRequestByEmail(email: email);
      return Right(token);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi quên mật khẩu', message: e.description ?? 'Lỗi quên mật khẩu'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, void>> resetPassword({
    required String otp,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        otp: otp,
        token: token,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return const Right(null);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đặt lại mật khẩu', message: e.description ?? 'Lỗi đặt lại mật khẩu'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation,
      );
      return const Right(null);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi đổi mật khẩu', message: e.description ?? 'Lỗi đổi mật khẩu'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, MyPointHistoryPaginationEntity>> getMyPointHistory({
    required int offset,
    required int limit,
    String? search,
    String? sort,
    PointHistoryType? type,
  }) async {
    try {
      final response = await remoteDataSource.getMyPointHistory(
        offset: offset,
        limit: limit,
        search: search,
        sort: sort,
        type: type,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi lấy lịch sử điểm', message: e.description ?? 'Lỗi lấy lịch sử điểm'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, List<MyGiftsEntity>>> getMyGifts({
    GiftStatus? status,
  }) async {
    try {
      final response = await remoteDataSource.getMyGifts(
        status: status,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi lấy danh sách quà', message: e.description ?? 'Lỗi lấy danh sách quà'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }

  @override
  Future<Either<AuthFailure, MyCoursePaginationEntity>> getMyCourse({
    int? isCompleted,
  }) async {
    try {
      final response = await remoteDataSource.getMyCourse(
        isCompleted: isCompleted,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(HttpFailure(title: 'Lỗi lấy danh sách khóa học', message: e.description ?? 'Lỗi lấy danh sách khóa học'));
    } catch (e) {
      return Left(UnknownFailure(title: 'Lỗi không xác định', message: 'Lỗi không xác định'));
    }
  }
}
