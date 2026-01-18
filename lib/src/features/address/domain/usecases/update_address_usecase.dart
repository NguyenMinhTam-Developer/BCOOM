import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class UpdateAddressParams {
  final int id;
  final String? name;
  final String? phone;
  final String? street;
  final String? note;
  final String? wardCode;
  final String? provinceCode;
  final num? lat;
  final num? lng;
  final bool? isDefault;

  const UpdateAddressParams({
    required this.id,
    this.name,
    this.phone,
    this.street,
    this.note,
    this.wardCode,
    this.provinceCode,
    this.lat,
    this.lng,
    this.isDefault,
  });
}

class UpdateAddressUseCase extends UseCase<AddressEntity, UpdateAddressParams> {
  final AddressRepository _addressRepository;

  UpdateAddressUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, AddressEntity>> call(UpdateAddressParams params) async {
    return await _addressRepository.updateAddress(
      id: params.id,
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
