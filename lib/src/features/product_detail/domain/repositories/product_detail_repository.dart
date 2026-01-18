import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_detail_entity.dart';
import '../entities/related_products_entity.dart';

abstract class ProductDetailRepository {
  Future<Either<ProductDetailFailure, ProductDetailEntity>> getProductDetail({
    required String nameSlug,
  });

  Future<Either<ProductDetailFailure, RelatedProductsEntity>> getRelatedProducts({
    required String nameSlug,
  });
}

