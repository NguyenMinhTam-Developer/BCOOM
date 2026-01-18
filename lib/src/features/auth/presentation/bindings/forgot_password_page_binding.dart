import 'package:get/get.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendResetPasswordRequestByEmailUseCase>(
      () => SendResetPasswordRequestByEmailUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(Get.find<SendResetPasswordRequestByEmailUseCase>()),
    );
  }
}
