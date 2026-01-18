import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/session/session_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../repositories/token_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

class LoginWithEmailParams {
  final Email email;
  final Password password;

  const LoginWithEmailParams({
    required this.email,
    required this.password,
  });

  static Either<InputValidationFailure, LoginWithEmailParams> create({
    required String email,
    required String password,
  }) {
    final emailValidation = Email.create(email);
    final passwordValidation = Password.create(password);

    return emailValidation.fold(
      (failure) => left(failure),
      (validEmail) => passwordValidation.fold(
        (failure) => left(failure),
        (validPassword) => right(LoginWithEmailParams(
          email: validEmail,
          password: validPassword,
        )),
      ),
    );
  }
}

class LoginWithEmail extends UseCase<AuthResponse, LoginWithEmailParams> {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  LoginWithEmail({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(LoginWithEmailParams params) async {
    final authResult = await _authRepository.loginWithEmail(
      email: params.email.value,
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
        // Save token
        final tokenResult = await _tokenRepository.saveToken(authResponse.data.token);

        await SessionService.instance.updateSession(authResponse);

        return tokenResult.fold(
          (failure) => left(failure),
          (_) {
            return right(authResponse);
          },
        );
      },
    );
  }
}
