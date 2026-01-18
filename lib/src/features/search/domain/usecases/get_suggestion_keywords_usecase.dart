import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/suggestion_keyword_list_entity.dart';
import '../repositories/search_repository.dart';

class GetSuggestionKeywordsParams {
  final String search;
  final int offset;
  final int limit;

  const GetSuggestionKeywordsParams({
    required this.search,
    required this.offset,
    required this.limit,
  });
}

class GetSuggestionKeywordsUseCase extends UseCase<SuggestionKeywordListEntity, GetSuggestionKeywordsParams> {
  final SearchRepository _searchRepository;

  GetSuggestionKeywordsUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  @override
  Future<Either<Failure, SuggestionKeywordListEntity>> call(GetSuggestionKeywordsParams params) async {
    return await _searchRepository.getSuggestionKeywords(
      search: params.search,
      offset: params.offset,
      limit: params.limit,
    );
  }
}










