import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/token_repository.dart';
import '../source/token_local_data_source.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource localDataSource;

  TokenRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AuthFailure, void>> saveToken(String token) async {
    try {
      await localDataSource.saveToken(token);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(title: 'Lỗi lưu token', message: 'Lỗi lưu token'));
    }
  }

  @override
  Future<Either<AuthFailure, String?>> getToken() async {
    try {
      final token = await localDataSource.getToken();
      return Right(token);
    } catch (e) {
      return const Left(ServerFailure(title: 'Lỗi lấy token', message: 'Lỗi lấy token'));
    }
  }

  @override
  Future<Either<AuthFailure, void>> deleteToken() async {
    try {
      await localDataSource.deleteToken();
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(title: 'Lỗi xóa token', message: 'Lỗi xóa token'));
    }
  }
}
