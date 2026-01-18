import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/api_file.dart';

abstract class UploadFileRepository {
  Future<Either<Failure, List<ApiFileEntity>>> uploadFileAuthorized({required List<File> files});

  Future<Either<Failure, List<ApiFileEntity>>> uploadFileUnauthorized({required List<File> files, required String token});

  Future<Either<Failure, List<ApiFileEntity>>> uploadFileCustomer({required List<File> files});
}
