import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SendResetPasswordRequestByEmailParams {
  final String email;
  const SendResetPasswordRequestByEmailParams({required this.email});
}

class SendResetPasswordRequestByEmailUseCase extends UseCase<String, SendResetPasswordRequestByEmailParams> {
  final AuthRepository _authRepository;
  SendResetPasswordRequestByEmailUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(SendResetPasswordRequestByEmailParams params) async {
    return await _authRepository.sendResetPasswordRequestByEmail(email: params.email);
  }
}
