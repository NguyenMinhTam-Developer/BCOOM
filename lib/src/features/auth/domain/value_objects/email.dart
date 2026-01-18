import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class Email {
  final String value;

  const Email._(this.value);

  static Either<InputValidationFailure, Email> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const InputValidationFailure(title: 'Email', message: 'Vui lòng nhập email'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return left(const InputValidationFailure(title: 'Email', message: 'Email không hợp lệ'));
    }

    return right(Email._(input));
  }
}
