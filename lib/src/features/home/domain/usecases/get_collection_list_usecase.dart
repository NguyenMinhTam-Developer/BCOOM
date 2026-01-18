import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/collection_list_entity.dart';
import '../repositories/home_repository.dart';

class GetCollectionListUseCase extends UseCase<CollectionListEntity, NoParams> {
  final HomeRepository _homeRepository;

  GetCollectionListUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, CollectionListEntity>> call(NoParams params) async {
    return await _homeRepository.getCollectionList();
  }
}

