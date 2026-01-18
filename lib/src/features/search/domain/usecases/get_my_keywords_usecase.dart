import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/my_keyword_entity.dart';
import '../repositories/search_repository.dart';

class GetMyKeywordsUseCase extends UseCase<List<MyKeywordEntity>, NoParams> {
  final SearchRepository _searchRepository;

  GetMyKeywordsUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  @override
  Future<Either<Failure, List<MyKeywordEntity>>> call(NoParams params) async {
    return await _searchRepository.getMyKeywords();
  }
}










