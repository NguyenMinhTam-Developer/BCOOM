import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/my_keyword_entity.dart';
import '../entities/search_result_entity.dart';
import '../entities/suggestion_keyword_list_entity.dart';

abstract class SearchRepository {
  /// Get my keywords
  Future<Either<SearchFailure, List<MyKeywordEntity>>> getMyKeywords();

  /// Get suggestion keywords
  Future<Either<SearchFailure, SuggestionKeywordListEntity>> getSuggestionKeywords({
    required String search,
    required int offset,
    required int limit,
  });

  /// Search products
  Future<Either<SearchFailure, SearchResultEntity>> search({
    required String collectionSlug,
    required String search,
    int? offset,
    int? limit,
    String? sort,
    String? order,
  });
}
