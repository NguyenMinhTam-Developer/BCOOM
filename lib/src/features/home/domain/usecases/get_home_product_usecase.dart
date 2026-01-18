import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class GetHomeProductUseCase extends UseCase<Map<String, dynamic>, GetHomeProductParams> {
  final HomeRepository _homeRepository;

  GetHomeProductUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(GetHomeProductParams params) async {
    return await _homeRepository.getHomeProduct(params.keywords);
  }
}

class GetHomeProductParams {
  final Map<String, dynamic> keywords;

  GetHomeProductParams({
    required this.keywords,
  });
}
