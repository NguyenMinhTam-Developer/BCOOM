import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/paginated_viewed_product_list_entity.dart';
import '../repositories/viewed_product_repository.dart';

class GetViewedProductsParams {
  final int offset;
  final int limit;

  const GetViewedProductsParams({
    required this.offset,
    required this.limit,
  });
}

class GetViewedProductsUseCase extends UseCase<PaginatedViewedProductListEntity, GetViewedProductsParams> {
  final ViewedProductRepository _repository;

  GetViewedProductsUseCase({
    required ViewedProductRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, PaginatedViewedProductListEntity>> call(GetViewedProductsParams params) async {
    return await _repository.getViewedProducts(
      offset: params.offset,
      limit: params.limit,
    );
  }
}

