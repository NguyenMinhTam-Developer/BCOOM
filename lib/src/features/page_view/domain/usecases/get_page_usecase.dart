import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/page_entity.dart';
import '../repositories/page_repository.dart';

class GetPageParams {
  final String slug;

  const GetPageParams({
    required this.slug,
  });
}

class GetPageUseCase extends UseCase<PageEntity, GetPageParams> {
  final PageRepository _repository;

  GetPageUseCase({
    required PageRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, PageEntity>> call(GetPageParams params) async {
    return await _repository.getPage(slug: params.slug);
  }
}
