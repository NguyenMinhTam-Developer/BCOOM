import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/faq_category_list_entity.dart';
import '../repositories/faq_repository.dart';

class GetFaqCategoriesUseCase extends UseCase<FaqCategoryListEntity, NoParams> {
  final FaqRepository _repository;

  GetFaqCategoriesUseCase({
    required FaqRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, FaqCategoryListEntity>> call(NoParams params) async {
    return await _repository.getFaqCategories();
  }
}
