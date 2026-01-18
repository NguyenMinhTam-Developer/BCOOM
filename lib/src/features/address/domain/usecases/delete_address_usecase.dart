import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/address_repository.dart';

class DeleteAddressParams {
  final int id;

  const DeleteAddressParams({
    required this.id,
  });
}

class DeleteAddressUseCase extends UseCase<void, DeleteAddressParams> {
  final AddressRepository _addressRepository;

  DeleteAddressUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<Either<Failure, void>> call(DeleteAddressParams params) async {
    return await _addressRepository.deleteAddress(id: params.id);
  }
}
