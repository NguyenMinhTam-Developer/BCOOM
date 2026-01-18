import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/faq_list_entity.dart';
import '../repositories/faq_repository.dart';

class GetFaqsParams {
  final int categoryId;

  GetFaqsParams({required this.categoryId});
}

class GetFaqsUseCase extends UseCase<FaqListEntity, GetFaqsParams> {
  final FaqRepository _repository;

  GetFaqsUseCase({
    required FaqRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, FaqListEntity>> call(GetFaqsParams params) async {
    return await _repository.getFaqs(categoryId: params.categoryId);
  }
}
