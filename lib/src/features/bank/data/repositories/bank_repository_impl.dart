import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/bank_entity.dart';
import '../../domain/repositories/bank_repository.dart';
import '../datasources/bank_remote_data_source.dart';

class BankRepositoryImpl implements BankRepository {
  final BankRemoteDataSource remoteDataSource;

  BankRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BankListEntity>> getBanks() async {
    try {
      final response = await remoteDataSource.getBanks();
      return Right(response);
    } on HttpException catch (e) {
      return Left(BankFailure(
        title: 'Lỗi tải danh sách ngân hàng',
        message: e.description ?? 'Lỗi tải danh sách ngân hàng',
      ));
    } catch (e) {
      return Left(BankFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, List<BankOptionEntity>>> getBankOptions() async {
    try {
      final response = await remoteDataSource.getBankOptions();
      return Right(response);
    } on HttpException catch (e) {
      return Left(BankFailure(
        title: 'Lỗi tải danh sách ngân hàng',
        message: e.description ?? 'Lỗi tải danh sách ngân hàng',
      ));
    } catch (e) {
      return Left(BankFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, BankEntity>> createBank({
    required int bankId,
    required String accountNumber,
    required String accountName,
  }) async {
    try {
      final response = await remoteDataSource.createBank(
        bankId: bankId,
        accountNumber: accountNumber,
        accountName: accountName,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(BankFailure(
        title: 'Lỗi tạo tài khoản ngân hàng',
        message: e.description ?? 'Lỗi tạo tài khoản ngân hàng',
      ));
    } catch (e) {
      return Left(BankFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBank({
    required int id,
  }) async {
    try {
      await remoteDataSource.deleteBank(id: id);
      return const Right(null);
    } on HttpException catch (e) {
      return Left(BankFailure(
        title: 'Lỗi xóa tài khoản ngân hàng',
        message: e.description ?? 'Lỗi xóa tài khoản ngân hàng',
      ));
    } catch (e) {
      return Left(BankFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
