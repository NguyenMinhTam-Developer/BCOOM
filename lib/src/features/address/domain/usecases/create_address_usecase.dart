import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class CreateAddressParams {
  final String name;
  final String phone;
  final String street;
  final String? note;
  final String? wardCode;
  final String? provinceCode;
  final num? lat;
  final num? lng;
  final bool isDefault;

  const CreateAddressParams({
    required this.name,
    required this.phone,
    required this.street,
    this.note,
    this.wardCode,
    this.provinceCode,
    this.lat,
    this.lng,
    this.isDefault = false,
  });
}

class CreateAddressUseCase extends UseCase<AddressEntity, CreateAddressParams> {
  final AddressRepository _addressRepository;

  CreateAddressUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, AddressEntity>> call(CreateAddressParams params) async {
    return await _addressRepository.createAddress(
      name: params.name,
      phone: params.phone,
      street: params.street,
      note: params.note,
      wardCode: params.wardCode,
      provinceCode: params.provinceCode,
      lat: params.lat,
      lng: params.lng,
      isDefault: params.isDefault,
    );
  }
}
