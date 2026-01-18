import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

class SearchParams {
  final String collectionSlug;
  final String search;
  final int? offset;
  final int? limit;
  final String? sort;
  final String? order;

  const SearchParams({
    required this.collectionSlug,
    required this.search,
    this.offset,
    this.limit,
    this.sort,
    this.order,
  });
}

class SearchUseCase extends UseCase<SearchResultEntity, SearchParams> {
  final SearchRepository _searchRepository;

  SearchUseCase({
    required SearchRepository searchRepository,
  }) : _searchRepository = searchRepository;

  @override
  Future<Either<Failure, SearchResultEntity>> call(SearchParams params) async {
    return await _searchRepository.search(
      collectionSlug: params.collectionSlug,
      search: params.search,
      offset: params.offset,
      limit: params.limit,
      sort: params.sort,
      order: params.order,
    );
  }
}










