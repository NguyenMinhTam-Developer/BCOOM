import 'package:bcoom/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/collection_list_entity.dart';
import '../../../product_detail/domain/entities/paginated_product_list_entity.dart';
import '../entities/product_side_bar_entity.dart';
import '../entities/product_sub_side_bar_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, ProductSideBarEntity>> getProductSideBar({
    required String slug,
    required String type,
    String? name,
  });

  Future<Either<Failure, ProductSubSideBarEntity>> getProductSubSideBar({
    required String slug,
    required String type,
    String? name,
  });

  Future<Either<Failure, CollectionListEntity>> getCollectionList();

  Future<Either<Failure, PaginatedProductListEntity>> getProductList({
    required String slug,
    required String collectionSlug,
    int? brandId,
    required int offset,
    required int limit,
  });
}
