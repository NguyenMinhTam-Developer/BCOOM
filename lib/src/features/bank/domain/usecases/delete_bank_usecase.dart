import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bank_repository.dart';

class DeleteBankParams {
  final int id;

  const DeleteBankParams({
    required this.id,
  });
}

class DeleteBankUseCase extends UseCase<void, DeleteBankParams> {
  final BankRepository _bankRepository;

  DeleteBankUseCase({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<Either<Failure, void>> call(DeleteBankParams params) async {
    return await _bankRepository.deleteBank(id: params.id);
  }
}
