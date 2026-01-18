import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import 'password.dart';

class ChangePasswordParams {
  final Password oldPassword;
  final Password newPassword;
  final Password passwordConfirmation;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
    required this.passwordConfirmation,
  });

  static Either<InputValidationFailure, ChangePasswordParams> create({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) {
    final oldPasswordValidation = Password.create(oldPassword);
    final newPasswordValidation = Password.create(newPassword);
    final passwordConfirmationValidation = Password.create(passwordConfirmation);

    return oldPasswordValidation.fold(
      (failure) => left(failure),
      (validOldPassword) => newPasswordValidation.fold(
        (failure) => left(failure),
        (validNewPassword) => passwordConfirmationValidation.fold(
          (failure) => left(failure),
          (validPasswordConfirmation) {
            if (validNewPassword.value != validPasswordConfirmation.value) {
              return left(const InputValidationFailure(
                message: 'Mật khẩu xác nhận không khớp',
              ));
            }

            if (validOldPassword.value == validNewPassword.value) {
              return left(const InputValidationFailure(
                message: 'Mật khẩu mới không được trùng với mật khẩu cũ',
              ));
            }

            return right(ChangePasswordParams(
              oldPassword: validOldPassword,
              newPassword: validNewPassword,
              passwordConfirmation: validPasswordConfirmation,
            ));
          },
        ),
      ),
    );
  }
}
