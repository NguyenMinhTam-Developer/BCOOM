import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/api_file.dart';
import '../repositories/upload_file_repository.dart';

class UploadFileParam {
  final List<File>? files;
  final String? token;

  UploadFileParam({required this.files, required this.token});
}

class UploadFileUseCase implements UseCase<List<ApiFileEntity>, UploadFileParam> {
  final UploadFileRepository repository;

  UploadFileUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ApiFileEntity>>> call(UploadFileParam params) async {
    if (params.files?.isEmpty ?? true) {
      return Left(
        UploadFileFailure(
          message: 'Vui lòng chọn file',
        ),
      );
    }

    if (params.token?.isEmpty ?? true) {
      return Left(
        UploadFileFailure(
          message: 'Không có quyền truy cập',
        ),
      );
    }

    return await repository.uploadFileUnauthorized(files: params.files!, token: params.token!);
  }
}
