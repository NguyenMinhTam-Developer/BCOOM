import 'package:get/get.dart';

import '../../../../core/di/tdd_binding.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordBinding extends TddBinding {
  @override
  void initDataSource() {
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
    );
  }

  @override
  void initRepository() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
      ),
    );
  }

  @override
  void initUseCase() {
    Get.lazyPut<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(
        Get.find<AuthRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(
        otp: Get.parameters['otp'] ?? '',
        token: Get.parameters['token'] ?? '',
        onSuccess: Get.arguments?['onSuccess'],
        onFailure: Get.arguments?['onFailure'],
      ),
    );
  }
}
