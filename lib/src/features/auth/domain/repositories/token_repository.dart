import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class TokenRepository {
  Future<Either<AuthFailure, void>> saveToken(String token);
  Future<Either<AuthFailure, String?>> getToken();
  Future<Either<AuthFailure, void>> deleteToken();
}
