import 'package:get/get.dart';

import '../../../../core/di/tdd_binding.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/token_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../data/source/token_local_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/token_repository.dart';
import '../../domain/usecases/register_cooperation_usecase.dart';
import '../controllers/sale_register_controller.dart';

class SaleRegisterBinding extends TddBinding {
  @override
  Future<void> initDataSource() async {
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
  }

  @override
  Future<void> initRepository() async {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
    );

    Get.lazyPut<TokenRepository>(
      () => TokenRepositoryImpl(Get.find<TokenLocalDataSource>()),
    );
  }

  @override
  Future<void> initUseCase() async {
    Get.lazyPut<RegisterCooperationUseCase>(
      () => RegisterCooperationUseCase(
        authRepository: Get.find<AuthRepository>(),
      ),
    );
  }

  @override
  Future<void> initController() async {
    Get.lazyPut<SaleRegisterController>(
      () => SaleRegisterController(
        registerCooperationUseCase: Get.find<RegisterCooperationUseCase>(),
      ),
    );
  }
}
