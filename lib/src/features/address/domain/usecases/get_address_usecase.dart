import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressParams {
  final int id;

  const GetAddressParams({
    required this.id,
  });
}

class GetAddressUseCase extends UseCase<AddressEntity, GetAddressParams> {
  final AddressRepository _addressRepository;

  GetAddressUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, AddressEntity>> call(GetAddressParams params) async {
    return await _addressRepository.getAddress(id: params.id);
  }
}
