import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, AddressListEntity>> getAddresses();

  Future<Either<Failure, AddressEntity>> createAddress({
    required String name,
    required String phone,
    required String street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool isDefault = false,
  });

  Future<Either<Failure, AddressEntity>> updateAddress({
    required int id,
    String? name,
    String? phone,
    String? street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool? isDefault,
  });

  Future<Either<Failure, AddressEntity>> getAddress({
    required int id,
  });

  Future<Either<Failure, AddressEntity>> setDefaultAddress({
    required int id,
  });

  Future<Either<Failure, void>> deleteAddress({
    required int id,
  });
}
