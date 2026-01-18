import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bank_entity.dart';
import '../repositories/bank_repository.dart';

class CreateBankParams {
  final int bankId;
  final String accountNumber;
  final String accountName;

  const CreateBankParams({
    required this.bankId,
    required this.accountNumber,
    required this.accountName,
  });
}

class CreateBankUseCase extends UseCase<BankEntity, CreateBankParams> {
  final BankRepository _bankRepository;

  CreateBankUseCase({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<Either<Failure, BankEntity>> call(CreateBankParams params) async {
    return await _bankRepository.createBank(
      bankId: params.bankId,
      accountNumber: params.accountNumber,
      accountName: params.accountName,
    );
  }
}
