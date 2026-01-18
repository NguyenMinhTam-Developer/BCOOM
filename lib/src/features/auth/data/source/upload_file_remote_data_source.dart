import 'dart:io' as io;

import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../models/upload_file_model.dart';

abstract class UploadFileRemoteDataSource {
  Future<List<UploadFileModel>> uploadFileAuthorized({required List<io.File> files});

  Future<List<UploadFileModel>> uploadFileUnauthorized({required List<io.File> files, required String token});

  Future<List<UploadFileModel>> uploadFileCustomer({required List<io.File> files});
}

class AuthorizedUploadFileRemoteDataSourceImpl implements UploadFileRemoteDataSource {
  final AuthorizedClient _authorizedClient;
  final UnauthorizedClient _unauthorizedClient;

  AuthorizedUploadFileRemoteDataSourceImpl(this._authorizedClient, this._unauthorizedClient);

  @override
  Future<List<UploadFileModel>> uploadFileAuthorized({required List<io.File> files}) async {
    final formData = FormData({});

    for (var file in files) {
      formData.files.add(
        MapEntry("files[]", MultipartFile(file, filename: file.path.split('/').last)),
      );
    }

    final response = await _authorizedClient.post(
      '/pharmacy/upload-tmp',
      formData,
    );

    return List<UploadFileModel>.from(response.body['files'].map((e) => UploadFileModel.fromJson(e)));
  }

  @override
  Future<List<UploadFileModel>> uploadFileUnauthorized({required List<io.File> files, required String token}) async {
    final formData = FormData({});

    for (var file in files) {
      formData.files.add(
        MapEntry("files[]", MultipartFile(file, filename: file.path.split('/').last)),
      );
    }

    final response = await _unauthorizedClient.post(
      '/pharmacy/upload-tmp',
      formData,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return List<UploadFileModel>.from(response.body['files'].map((e) => UploadFileModel.fromJson(e)));
  }

  @override
  Future<List<UploadFileModel>> uploadFileCustomer({required List<io.File> files}) async {
    final formData = FormData({});

    for (var file in files) {
      formData.files.add(
        MapEntry("files[]", MultipartFile(file, filename: file.path.split('/').last)),
      );
    }

    final response = await _authorizedClient.post(
      '/api/customers/upload-tmp',
      formData,
    );

    RemoteDataSource.handleResponse(response);

    return List<UploadFileModel>.from(response.body['files'].map((e) => UploadFileModel.fromJson(e)));
  }
}
