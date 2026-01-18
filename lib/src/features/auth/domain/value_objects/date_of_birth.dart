import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class DateOfBirth {
  final DateTime value;

  const DateOfBirth._(this.value);

  static Either<InputValidationFailure, DateOfBirth> create(DateTime? input) {
    if (input == null) {
      return Left(InputValidationFailure(message: 'Ngày sinh không được để trống'));
    }

    final now = DateTime.now();
    final minDate = DateTime(1900, 1, 1);

    if (input.isAfter(now)) {
      return Left(InputValidationFailure(message: 'Ngày sinh không được trong tương lai'));
    }
    if (input.isBefore(minDate)) {
      return Left(InputValidationFailure(message: 'Ngày sinh không được trước năm 1900'));
    }

    return Right(DateOfBirth._(input));
  }
}
