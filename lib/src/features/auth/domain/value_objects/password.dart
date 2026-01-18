import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class Password {
  final String value;

  const Password._(this.value);

  static Either<InputValidationFailure, Password> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const InputValidationFailure(message: 'Vui lòng nhập mật khẩu'));
    }

    if (input.length < 6) {
      return left(const InputValidationFailure(message: 'Mật khẩu phải có ít nhất 6 ký tự'));
    }

    return right(Password._(input));
  }
}
