import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/change_password_params.dart';

class ChangePassword extends UseCase<void, ChangePasswordParams> {
  final AuthRepository _authRepository;

  ChangePassword({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await _authRepository.changePassword(
      oldPassword: params.oldPassword.value,
      newPassword: params.newPassword.value,
      passwordConfirmation: params.passwordConfirmation.value,
    );
  }
}
