import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/related_products_entity.dart';
import '../repositories/product_detail_repository.dart';

class GetRelatedProductsParams {
  final String nameSlug;

  const GetRelatedProductsParams({
    required this.nameSlug,
  });
}

class GetRelatedProductsUseCase extends UseCase<RelatedProductsEntity, GetRelatedProductsParams> {
  final ProductDetailRepository _productDetailRepository;

  GetRelatedProductsUseCase({
    required ProductDetailRepository productDetailRepository,
  }) : _productDetailRepository = productDetailRepository;

  @override
  Future<Either<Failure, RelatedProductsEntity>> call(GetRelatedProductsParams params) async {
    return await _productDetailRepository.getRelatedProducts(
      nameSlug: params.nameSlug,
    );
  }
}
