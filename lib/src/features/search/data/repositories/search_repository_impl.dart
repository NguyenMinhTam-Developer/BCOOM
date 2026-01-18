import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/my_keyword_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/suggestion_keyword_list_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../source/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<SearchFailure, List<MyKeywordEntity>>> getMyKeywords() async {
    try {
      final response = await remoteDataSource.getMyKeywords();
      return Right(response);
    } on HttpException catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi tải từ khóa',
        message: e.description ?? 'Lỗi tải từ khóa',
      ));
    } catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<SearchFailure, SuggestionKeywordListEntity>> getSuggestionKeywords({
    required String search,
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getSuggestionKeywords(
        search: search,
        offset: offset,
        limit: limit,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi tải gợi ý từ khóa',
        message: e.description ?? 'Lỗi tải gợi ý từ khóa',
      ));
    } catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<SearchFailure, SearchResultEntity>> search({
    required String collectionSlug,
    required String search,
    int? offset,
    int? limit,
    String? sort,
    String? order,
  }) async {
    try {
      final response = await remoteDataSource.search(
        collectionSlug: collectionSlug,
        search: search,
        offset: offset,
        limit: limit,
        sort: sort,
        order: order,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi tìm kiếm',
        message: e.description ?? 'Lỗi tìm kiếm',
      ));
    } catch (e) {
      return Left(SearchFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
