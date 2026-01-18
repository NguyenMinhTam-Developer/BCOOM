import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bank_entity.dart';
import '../repositories/bank_repository.dart';

class GetBankOptionsUseCase extends UseCase<List<BankOptionEntity>, NoParams> {
  final BankRepository _bankRepository;

  GetBankOptionsUseCase({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<Either<Failure, List<BankOptionEntity>>> call(NoParams params) async {
    return await _bankRepository.getBankOptions();
  }
}
