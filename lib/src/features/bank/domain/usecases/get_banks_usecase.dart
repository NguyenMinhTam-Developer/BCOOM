import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bank_entity.dart';
import '../repositories/bank_repository.dart';

class GetBanksUseCase extends UseCase<BankListEntity, NoParams> {
  final BankRepository _bankRepository;

  GetBanksUseCase({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<Either<Failure, BankListEntity>> call(NoParams params) async {
    return await _bankRepository.getBanks();
  }
}
