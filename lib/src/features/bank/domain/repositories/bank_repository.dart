import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bank_entity.dart';

abstract class BankRepository {
  Future<Either<Failure, BankListEntity>> getBanks();

  Future<Either<Failure, List<BankOptionEntity>>> getBankOptions();

  Future<Either<Failure, BankEntity>> createBank({
    required int bankId,
    required String accountNumber,
    required String accountName,
  });

  Future<Either<Failure, void>> deleteBank({
    required int id,
  });
}
