import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_sub_side_bar_entity.dart';
import '../repositories/category_repository.dart';

class GetProductSubSideBarParams {
  final String slug;
  final String type;
  final String? name;

  const GetProductSubSideBarParams({
    required this.slug,
    required this.type,
    this.name,
  });
}

class GetProductSubSideBarUseCase extends UseCase<ProductSubSideBarEntity, GetProductSubSideBarParams> {
  final CategoryRepository _categoryRepository;

  GetProductSubSideBarUseCase({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Either<Failure, ProductSubSideBarEntity>> call(GetProductSubSideBarParams params) async {
    return await _categoryRepository.getProductSubSideBar(
      slug: params.slug,
      type: params.type,
      name: params.name,
    );
  }
}
