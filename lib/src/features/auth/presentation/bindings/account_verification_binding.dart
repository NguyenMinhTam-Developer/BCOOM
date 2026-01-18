import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';
import '../../domain/usecases/send_verification_notification_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../controllers/account_verification_controller.dart';

class AccountVerificationBinding extends Bindings {
  @override
  void dependencies() {
    final unauthorizedClient = Get.find<UnauthorizedClient>();
    final authorizedClient = Get.find<AuthorizedClient>();

    final remoteDataSource = AuthRemoteDataSourceImpl(
      unauthorizedClient: unauthorizedClient,
      authorizedClient: authorizedClient,
    );

    final repository = AuthRepositoryImpl(remoteDataSource);
    final sendVerificationNotificationUseCase = SendVerificationNotificationUseCase(repository);
    final verifyOtpUseCase = VerifyOtpUseCase(repository);

    Get.lazyPut<AccountVerificationController>(
      () => AccountVerificationController(
        sendVerificationNotificationUseCase,
        verifyOtpUseCase,
      ),
    );
  }
}
