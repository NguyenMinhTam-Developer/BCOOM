import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_list_entity.dart';
import '../repositories/location_repository.dart';

class GetProvincesUseCase extends UseCase<ProvinceListEntity, NoParams> {
  final LocationRepository _locationRepository;

  GetProvincesUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<Either<Failure, ProvinceListEntity>> call(NoParams params) async {
    return await _locationRepository.getProvinces();
  }
}
