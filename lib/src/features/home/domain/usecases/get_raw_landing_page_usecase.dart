import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class GetRawLandingPageUseCase extends UseCase<Map<String, dynamic>, NoParams> {
  final HomeRepository _homeRepository;

  GetRawLandingPageUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    return await _homeRepository.getRawLandingPage();
  }
}
