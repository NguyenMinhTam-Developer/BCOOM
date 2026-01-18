import 'package:get/get.dart';

import '../../../../core/di/tdd_binding.dart';
import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/send_verification_notification_usecase.dart';
import '../controllers/generic_otp_verification_controller.dart';

class GenericOtpVerificationBinding extends TddBinding {
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
    Get.lazyPut<SendVerificationNotificationUseCase>(
      () => SendVerificationNotificationUseCase(
        Get.find<AuthRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.lazyPut<GenericOtpVerificationController>(
      () => GenericOtpVerificationController(
        email: Get.parameters['email'] ?? '',
        token: Get.parameters['token'] ?? '',
        onSuccess: Get.arguments?['onSuccess'],
        onFailure: Get.arguments?['onFailure'],
      ),
    );
  }
}
