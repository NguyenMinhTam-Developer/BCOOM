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
import '../../domain/usecases/login_with_bcoomid.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/login_with_phone.dart';
import '../controllers/login_controller.dart';

class LoginBinding implements Bindings {
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

    Get.lazyPut<LoginWithEmail>(
      () => LoginWithEmail(
        authRepository: Get.find<AuthRepository>(),
        tokenRepository: Get.find<TokenRepository>(),
      ),
    );

    Get.lazyPut<LoginWithPhone>(
      () => LoginWithPhone(
        authRepository: Get.find<AuthRepository>(),
        tokenRepository: Get.find<TokenRepository>(),
      ),
    );

    Get.lazyPut<LoginWithIdBcoom>(
      () => LoginWithIdBcoom(
        authRepository: Get.find<AuthRepository>(),
        tokenRepository: Get.find<TokenRepository>(),
      ),
    );

    // Register controller using dependencies already initialized by AuthDI
    Get.lazyPut<LoginController>(
      () => LoginController(
        loginWithEmail: Get.find<LoginWithEmail>(),
        loginWithPhone: Get.find<LoginWithPhone>(),
        loginWithIdBcoom: Get.find<LoginWithIdBcoom>(),
      ),
    );
  }
}
