import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/token_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../data/source/token_local_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/token_repository.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
    );

    Get.lazyPut<TokenLocalDataSource>(
      () => TokenLocalDataSourceImpl(
        Get.find<LocalStorageService>(),
      ),
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
      ),
    );

    Get.lazyPut<TokenRepository>(
      () => TokenRepositoryImpl(
        Get.find<TokenLocalDataSource>(),
      ),
    );

    Get.lazyPut<ChangePassword>(
      () => ChangePassword(
        authRepository: Get.find<AuthRepository>(),
      ),
    );

    // Register controller using dependencies already initialized by AuthDI
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        changePassword: Get.find<ChangePassword>(),
      ),
    );
  }
}
