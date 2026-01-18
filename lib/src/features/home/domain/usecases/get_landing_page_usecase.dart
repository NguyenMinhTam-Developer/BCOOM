import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/landing_page_entity.dart';
import '../repositories/home_repository.dart';

class GetLandingPageUseCase extends UseCase<LandingPageEntity, NoParams> {
  final HomeRepository _homeRepository;

  GetLandingPageUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, LandingPageEntity>> call(NoParams params) async {
    return await _homeRepository.getLandingPage();
  }
}
