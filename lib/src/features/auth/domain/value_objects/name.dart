import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class Name {
  final String value;

  const Name._(this.value);

  static Either<InputValidationFailure, Name> create(String? input) {
    if (input == null) {
      return Left(InputValidationFailure(message: 'Tên không được để trống'));
    }

    if (input.isEmpty) {
      return Left(InputValidationFailure(message: 'Tên không được để trống'));
    }
    if (input.length < 2) {
      return Left(InputValidationFailure(message: 'Tên phải có ít nhất 2 ký tự'));
    }
    if (input.length > 50) {
      return Left(InputValidationFailure(message: 'Tên không được dài hơn 50 ký tự'));
    }
    return Right(Name._(input.trim()));
  }
}
