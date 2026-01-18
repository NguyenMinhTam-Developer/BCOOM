import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class PasswordConfirmation {
  final String value;

  const PasswordConfirmation._(this.value);

  static Either<InputValidationFailure, PasswordConfirmation> create(String? input, String? originalPassword) {
    if (input == null || input.isEmpty) {
      return left(const InputValidationFailure(message: 'Vui lòng nhập xác nhận mật khẩu'));
    }

    if (input != originalPassword) {
      return left(const InputValidationFailure(message: 'Mật khẩu xác nhận không trùng khớp'));
    }

    return right(PasswordConfirmation._(input));
  }
}
