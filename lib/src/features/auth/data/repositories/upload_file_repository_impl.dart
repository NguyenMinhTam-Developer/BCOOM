import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/api_file.dart';
import '../../domain/repositories/upload_file_repository.dart';
import '../source/upload_file_remote_data_source.dart';

class UploadFileRepositoryImpl implements UploadFileRepository {
  final UploadFileRemoteDataSource _uploadFileRemoteDataSource;

  UploadFileRepositoryImpl(this._uploadFileRemoteDataSource);

  @override
  Future<Either<Failure, List<ApiFileEntity>>> uploadFileAuthorized({required List<File> files}) async {
    try {
      final response = await _uploadFileRemoteDataSource.uploadFileAuthorized(files: files);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(title: 'Lỗi đăng tải file', message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ApiFileEntity>>> uploadFileUnauthorized({required List<File> files, required String token}) async {
    try {
      final response = await _uploadFileRemoteDataSource.uploadFileUnauthorized(files: files, token: token);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(title: 'Lỗi đăng tải file', message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ApiFileEntity>>> uploadFileCustomer({required List<File> files}) async {
    try {
      final response = await _uploadFileRemoteDataSource.uploadFileCustomer(files: files);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(title: 'Lỗi đăng tải file', message: e.toString()));
    }
  }
}
