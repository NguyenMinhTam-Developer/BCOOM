import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/faq_list_entity.dart';
import '../repositories/faq_repository.dart';

class GetAllFaqsUseCase extends UseCase<FaqListEntity, NoParams> {
  final FaqRepository _repository;

  GetAllFaqsUseCase({
    required FaqRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, FaqListEntity>> call(NoParams params) async {
    return await _repository.getAllFaqs();
  }
}
