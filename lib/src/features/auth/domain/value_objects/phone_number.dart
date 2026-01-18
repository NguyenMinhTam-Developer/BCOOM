import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class PhoneNumber {
  final String value;

  const PhoneNumber._(this.value);

  static Either<InputValidationFailure, PhoneNumber> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const InputValidationFailure(message: 'Vui lòng nhập số điện thoại'));
    }

    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(input)) {
      return left(const InputValidationFailure(message: 'Số điện thoại không hợp lệ'));
    }

    return right(PhoneNumber._(input));
  }
}
