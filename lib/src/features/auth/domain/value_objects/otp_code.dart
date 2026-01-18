import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class OtpCode {
  final num value;

  const OtpCode._(this.value);

  static Either<Failure, OtpCode> create(num? input) {
    if (input == null) {
      return Left(ServerFailure(title: 'Lỗi mã OTP', message: 'Mã OTP không được để trống'));
    }

    if (input.toString().length != 6) {
      return Left(ServerFailure(title: 'Lỗi mã OTP', message: 'Mã OTP phải có 6 ký tự'));
    }

    if (!RegExp(r'^\d{6}$').hasMatch(input.toString())) {
      return Left(ServerFailure(title: 'Lỗi mã OTP', message: 'Mã OTP chỉ được chứa số'));
    }

    return Right(OtpCode._(input));
  }
}
