import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

enum CustomerTypeEnum {
  pharmacist,
  pharmacy;

  String get name => switch (this) {
        pharmacist => 'Dược sĩ',
        pharmacy => 'Chủ nhà thuốc',
      };

  String get value => switch (this) {
        pharmacist => 'pharmacist',
        pharmacy => 'pharmacy',
      };
}

class CustomerType {
  final CustomerTypeEnum value;

  const CustomerType._(this.value);

  static Either<InputValidationFailure, CustomerType> create(CustomerTypeEnum? input) {
    if (input == null) {
      return Left(InputValidationFailure(message: 'Vui lòng chọn loại tài khoản'));
    }

    return Right(CustomerType._(input));
  }

  static Either<Failure, CustomerType> fromEnum(CustomerTypeEnum type) {
    return Right(CustomerType._(type));
  }
}
