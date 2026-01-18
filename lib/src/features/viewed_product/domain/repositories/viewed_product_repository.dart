import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/paginated_viewed_product_list_entity.dart';

abstract class ViewedProductRepository {
  Future<Either<ViewedProductFailure, PaginatedViewedProductListEntity>> getViewedProducts({
    required int offset,
    required int limit,
  });
}

