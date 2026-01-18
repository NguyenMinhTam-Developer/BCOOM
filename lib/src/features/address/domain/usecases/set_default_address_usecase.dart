import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class SetDefaultAddressParams {
  final int id;

  const SetDefaultAddressParams({
    required this.id,
  });
}

class SetDefaultAddressUseCase extends UseCase<AddressEntity, SetDefaultAddressParams> {
  final AddressRepository _addressRepository;

  SetDefaultAddressUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, AddressEntity>> call(SetDefaultAddressParams params) async {
    return await _addressRepository.setDefaultAddress(id: params.id);
  }
}
