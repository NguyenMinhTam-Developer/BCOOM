import 'package:get/get.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../data/repositories/splash_repository_impl.dart';
import '../../domain/repositories/splash_repository.dart';
import '../../domain/usecases/check_first_launch.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(
      () => SplashRepositoryImpl(Get.find<LocalStorageService>()),
    );

    Get.lazyPut<CheckFirstLaunch>(
      () => CheckFirstLaunch(Get.find<SplashRepository>()),
    );

    Get.lazyPut(
      () => SplashController(
        checkFirstLaunch: Get.find<CheckFirstLaunch>(),
      ),
    );
  }
}
