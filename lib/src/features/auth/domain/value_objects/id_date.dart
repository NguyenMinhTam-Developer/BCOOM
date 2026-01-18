import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class IdDate {
  final DateTime? value;

  const IdDate._(this.value);

  static Either<InputValidationFailure, IdDate> create(DateTime? input) {
    if (input == null) {
      return Right(IdDate._(null));
    }

    final now = DateTime.now();
    final minDate = DateTime(2000, 1, 1);

    if (input.isAfter(now)) {
      return Left(InputValidationFailure(message: 'Ngày cấp CMND không được trong tương lai'));
    }
    if (input.isBefore(minDate)) {
      return Left(InputValidationFailure(message: 'Ngày cấp CMND không được trước năm 2000'));
    }

    return Right(IdDate._(input));
  }
}
