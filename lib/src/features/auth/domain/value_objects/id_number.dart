import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class IdNumber {
  final String? value;

  const IdNumber._(this.value);

  static Either<InputValidationFailure, IdNumber> create(String? input) {
    if (input == null) {
      return Right(IdNumber._(null));
    }

    if (input.isEmpty) {
      return Right(IdNumber._(null));
    }

    final cleanInput = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanInput.length != 9 && cleanInput.length != 12) {
      return Left(InputValidationFailure(message: 'Số CMND phải có 9 hoặc 12 chữ số'));
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanInput)) {
      return Left(InputValidationFailure(message: 'Số CMND chỉ được chứa các chữ số'));
    }

    return Right(IdNumber._(cleanInput));
  }
}
