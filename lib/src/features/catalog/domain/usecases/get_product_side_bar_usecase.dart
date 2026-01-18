import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_side_bar_entity.dart';
import '../repositories/category_repository.dart';

class GetProductSideBarParams {
  final String slug;
  final String type;
  final String? name;

  const GetProductSideBarParams({
    required this.slug,
    required this.type,
    this.name,
  });
}

class GetProductSideBarUseCase extends UseCase<ProductSideBarEntity, GetProductSideBarParams> {
  final CategoryRepository _categoryRepository;

  GetProductSideBarUseCase({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Either<Failure, ProductSideBarEntity>> call(GetProductSideBarParams params) async {
    return await _categoryRepository.getProductSideBar(
      slug: params.slug,
      type: params.type,
      name: params.name,
    );
  }
}

