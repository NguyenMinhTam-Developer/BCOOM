import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_list_entity.dart';
import '../repositories/location_repository.dart';

class GetWardsParams {
  final String districtId;

  GetWardsParams({
    required this.districtId,
  });
}

class GetWardsUseCase extends UseCase<WardListEntity, GetWardsParams> {
  final LocationRepository _locationRepository;

  GetWardsUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<Either<Failure, WardListEntity>> call(GetWardsParams params) async {
    return await _locationRepository.getWards(
      districtId: params.districtId,
    );
  }
}
