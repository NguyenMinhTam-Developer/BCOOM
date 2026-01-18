import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/brand_list_entity.dart';
import '../repositories/home_repository.dart';

class GetBrandListUseCase extends UseCase<BrandListEntity, GetBrandListParams> {
  final HomeRepository _homeRepository;

  GetBrandListUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, BrandListEntity>> call(GetBrandListParams params) async {
    return await _homeRepository.getBrandList(
      categoryId: params.categoryId,
      limit: params.limit,
      offset: params.offset,
      page: params.page,
      search: params.search,
      sort: params.sort,
    );
  }
}

class GetBrandListParams {
  final num? categoryId;
  final num? limit;
  final num? offset;
  final num? page;
  final String? search;
  final String? sort;

  GetBrandListParams({
    this.categoryId,
    this.limit,
    this.offset,
    this.page,
    this.search,
    this.sort,
  });
}
