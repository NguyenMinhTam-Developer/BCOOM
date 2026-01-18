import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../product_detail/domain/entities/paginated_product_list_entity.dart';
import '../repositories/category_repository.dart';

class GetProductListParams {
  final String slug;
  final String collectionSlug;
  final int? brandId;
  final int offset;
  final int limit;

  const GetProductListParams({
    required this.slug,
    required this.collectionSlug,
    this.brandId,
    required this.offset,
    required this.limit,
  });
}

class GetProductListUseCase extends UseCase<PaginatedProductListEntity, GetProductListParams> {
  final CategoryRepository _categoryRepository;

  GetProductListUseCase({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Either<Failure, PaginatedProductListEntity>> call(GetProductListParams params) async {
    return await _categoryRepository.getProductList(
      slug: params.slug,
      collectionSlug: params.collectionSlug,
      brandId: params.brandId,
      offset: params.offset,
      limit: params.limit,
    );
  }
}

