import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/session/session_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../repositories/token_repository.dart';
import '../value_objects/bcoomid.dart';
import '../value_objects/password.dart';

class LoginWithIdBcoomParams {
  final BcoomId bcoomId;
  final Password password;

  const LoginWithIdBcoomParams({
    required this.bcoomId,
    required this.password,
  });

  static Either<InputValidationFailure, LoginWithIdBcoomParams> create({
    required String bcoomId,
    required String password,
  }) {
    final bcoomIdValidation = BcoomId.create(bcoomId);
    final passwordValidation = Password.create(password);

    return bcoomIdValidation.fold(
      (failure) => left(failure),
      (validBcoomId) => passwordValidation.fold(
        (failure) => left(failure),
        (validPassword) => right(LoginWithIdBcoomParams(
          bcoomId: validBcoomId,
          password: validPassword,
        )),
      ),
    );
  }
}

class LoginWithIdBcoom extends UseCase<AuthResponse, LoginWithIdBcoomParams> {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  LoginWithIdBcoom({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(LoginWithIdBcoomParams params) async {
    // 1. Login
    final authResult = await _authRepository.loginWithIdBcoom(
      bcoomId: params.bcoomId.value,
      password: params.password.value,
    );

    return authResult.fold(
      (failure) async {
        if (failure is EmailNotVerifiedFailure) {
          // 2. Save token to local storage
          final tokenResult = await _tokenRepository.saveToken(failure.authResponse.data.token);
          if (tokenResult.isLeft()) {
            return left(UnknownFailure(title: 'Token Error', message: 'Failed to save authentication token'));
          }

          // 3. If user verified, fetch user profile and replace the new user data
          if (failure.authResponse.data.user.emailVerifiedAt != null) {
            final userProfileResult = await _authRepository.getProfile();
            return userProfileResult.fold(
              (failure) => left(failure),
              (userProfile) async {
                // Update auth response with new user data
                final updatedAuthResponse = failure.authResponse.copyWith(
                  data: failure.authResponse.data.copyWith(user: userProfile),
                );

                // 4. Save the session with updated data
                await SessionService.instance.updateSession(updatedAuthResponse);

                // 5. Return the updated auth response
                return right(updatedAuthResponse);
              },
            );
          }

          // 4. Save the session with original data
          await SessionService.instance.updateSession(failure.authResponse);

          // 5. Return the original auth response
          return right(failure.authResponse);
        }

        return left(failure);
      },
      (authResponse) async {
        // 2. Save token to local storage
        final tokenResult = await _tokenRepository.saveToken(authResponse.data.token);
        if (tokenResult.isLeft()) {
          return tokenResult.fold(
            (failure) => left(failure),
            (_) => left(UnknownFailure(
              title: 'Token Error',
              message: 'Failed to save authentication token',
            )),
          );
        }

        // 3. If user verified, fetch user profile and replace the new user data
        if (authResponse.data.user.emailVerifiedAt != null) {
          final userProfileResult = await _authRepository.getProfile();
          return userProfileResult.fold(
            (failure) => left(failure),
            (userProfile) async {
              // Update auth response with new user data
              final updatedAuthResponse = authResponse.copyWith(
                data: authResponse.data.copyWith(user: userProfile),
              );

              // 4. Save the session with updated data
              await SessionService.instance.updateSession(updatedAuthResponse);

              // 5. Return the updated auth response
              return right(updatedAuthResponse);
            },
          );
        }

        // 4. Save the session with original data
        await SessionService.instance.updateSession(authResponse);

        // 5. Return the original auth response
        return right(authResponse);
      },
    );
  }
}
