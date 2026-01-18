import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_list_entity.dart';
import '../repositories/location_repository.dart';

class GetCountriesUseCase extends UseCase<CountryListEntity, NoParams> {
  final LocationRepository _locationRepository;

  GetCountriesUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<Either<Failure, CountryListEntity>> call(NoParams params) async {
    return await _locationRepository.getCountries();
  }
}
