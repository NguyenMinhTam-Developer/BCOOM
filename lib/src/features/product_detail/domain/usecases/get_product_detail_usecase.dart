import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_detail_entity.dart';
import '../repositories/product_detail_repository.dart';

class GetProductDetailParams {
  final String nameSlug;

  const GetProductDetailParams({
    required this.nameSlug,
  });
}

class GetProductDetailUseCase extends UseCase<ProductDetailEntity, GetProductDetailParams> {
  final ProductDetailRepository _productDetailRepository;

  GetProductDetailUseCase({
    required ProductDetailRepository productDetailRepository,
  }) : _productDetailRepository = productDetailRepository;

  @override
  Future<Either<Failure, ProductDetailEntity>> call(GetProductDetailParams params) async {
    return await _productDetailRepository.getProductDetail(
      nameSlug: params.nameSlug,
    );
  }
}

