import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class BcoomId {
  final String value;

  const BcoomId._(this.value);

  static Either<InputValidationFailure, BcoomId> create(String? input) {
    if (input == null || input.isEmpty) {
      return left(const InputValidationFailure(message: 'Vui lòng nhập ID BCOOM'));
    }

    return right(BcoomId._(input));
  }
}
