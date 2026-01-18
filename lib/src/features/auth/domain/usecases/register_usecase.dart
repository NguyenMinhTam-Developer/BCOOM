import 'package:dartz/dartz.dart';
import '../../../../core/services/session/session_service.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../repositories/token_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';
import '../value_objects/password_confirmation.dart';
import '../value_objects/phone_number.dart';

class RegisterParams {
  final Email email;
  final PhoneNumber phoneNumber;
  final Password password;
  final PasswordConfirmation passwordConfirmation;

  const RegisterParams({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  static Either<InputValidationFailure, RegisterParams> create({
    required String? email,
    required String? phoneNumber,
    required String? password,
    required String? passwordConfirmation,
  }) {
    final emailValidation = Email.create(email);
    final phoneNumberValidation = PhoneNumber.create(phoneNumber);
    final passwordValidation = Password.create(password);
    final passwordConfirmationValidation = PasswordConfirmation.create(passwordConfirmation, password);

    return emailValidation.fold(
      (failure) => left(failure),
      (validEmail) => phoneNumberValidation.fold(
        (failure) => left(failure),
        (validPhoneNumber) => passwordValidation.fold(
          (failure) => left(failure),
          (validPassword) => passwordConfirmationValidation.fold(
            (failure) => left(failure),
            (validPasswordConfirmation) => right(RegisterParams(
              email: validEmail,
              phoneNumber: validPhoneNumber,
              password: validPassword,
              passwordConfirmation: validPasswordConfirmation,
            )),
          ),
        ),
      ),
    );
  }
}

class RegisterWithEmailUseCase extends UseCase<AuthResponse, RegisterParams> {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  RegisterWithEmailUseCase({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) async {
    final authResult = await _authRepository.register(
      email: params.email.value,
      phoneNumber: params.phoneNumber.value,
      password: params.password.value,
      passwordConfirmation: params.passwordConfirmation.value,
    );

    return authResult.fold(
      (failure) => left(failure),
      (authResponse) async {
        final tokenResult = await _tokenRepository.saveToken(authResponse.data.token);

        return tokenResult.fold(
          (failure) => left(failure),
          (_) async {
            await SessionService.instance.updateSession(authResponse);

            return right(authResponse);
          },
        );
      },
    );
  }
}
