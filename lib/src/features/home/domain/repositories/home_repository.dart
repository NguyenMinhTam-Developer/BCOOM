import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/brand_list_entity.dart';
import '../entities/collection_list_entity.dart';
import '../entities/landing_page_entity.dart';

abstract class HomeRepository {
  Future<Either<HomeFailure, LandingPageEntity>> getLandingPage();
  Future<Either<HomeFailure, Map<String, dynamic>>> getRawLandingPage();
  Future<Either<HomeFailure, BrandListEntity>> getBrandList({
    required num? categoryId,
    required num? limit,
    required num? offset,
    required num? page,
    required String? search,
    required String? sort,
  });

  Future<Either<HomeFailure, Map<String, dynamic>>> getHomeProduct(String keywords);
  Future<Either<HomeFailure, CollectionListEntity>> getCollectionList();
}
