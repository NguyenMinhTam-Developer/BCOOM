import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class GetAddressesUseCase extends UseCase<AddressListEntity, NoParams> {
  final AddressRepository _addressRepository;

  GetAddressesUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, AddressListEntity>> call(NoParams params) async {
    return await _addressRepository.getAddresses();
  }
}
