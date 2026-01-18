import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordParams {
  final String otp;
  final String token;
  final String password;
  final String passwordConfirmation;

  const ResetPasswordParams({
    required this.otp,
    required this.token,
    required this.password,
    required this.passwordConfirmation,
  });
}

class ResetPasswordUseCase extends UseCase<void, ResetPasswordParams> {
  final AuthRepository _authRepository;
  ResetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await _authRepository.resetPassword(
      otp: params.otp,
      token: params.token,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}
