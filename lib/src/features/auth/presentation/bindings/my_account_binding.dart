import 'package:get/get.dart';

import '../../../../core/di/tdd_binding.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/upload_file_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../data/source/upload_file_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/upload_file_repository.dart';
import '../../domain/usecases/update_profile.dart';
import '../controllers/my_account_controller.dart';

class MyAccountBinding extends TddBinding {
  @override
  Future<void> initDataSource() async {
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
    );

    Get.lazyPut<UploadFileRemoteDataSource>(
      () => AuthorizedUploadFileRemoteDataSourceImpl(
        Get.find<AuthorizedClient>(),
        Get.find<UnauthorizedClient>(),
      ),
    );
  }

  @override
  Future<void> initRepository() async {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
      ),
    );

    Get.lazyPut<UploadFileRepository>(
      () => UploadFileRepositoryImpl(Get.find<UploadFileRemoteDataSource>()),
    );
  }

  @override
  Future<void> initUseCase() async {
    Get.lazyPut<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(
        authRepository: Get.find<AuthRepository>(),
        uploadFileRepository: Get.find<UploadFileRepository>(),
      ),
    );
  }

  @override
  Future<void> initController() async {
    Get.lazyPut<MyAccountController>(
      () => MyAccountController(
        updateProfileUseCase: Get.find<UpdateProfileUseCase>(),
      ),
    );
  }
}
