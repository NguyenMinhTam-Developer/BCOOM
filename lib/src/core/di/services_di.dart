import 'package:get/get.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/source/auth_remote_data_source.dart';
import '../../features/bank/presentation/bindings/bank_binding.dart';
import '../../features/cart/presentation/bindings/cart_binding.dart';
import '../../features/location/presentation/bindings/location_binding.dart';
import '../network/authorized_client.dart';
import '../network/unauthorized_client.dart';
import '../services/local_storage_service.dart';
import '../services/session/session_service.dart';

class ServicesDI {
  static Future<void> init() async {
    await Get.putAsync(() => LocalStorageService().init(), permanent: true);

    Get.lazyPut<UnauthorizedClient>(
      () => UnauthorizedClient(),
      fenix: true,
    );

    Get.lazyPut<AuthorizedClient>(
      () => AuthorizedClient(
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    // // Initialize Firebase Messaging Service
    // Get.put(FirebaseMessagingService(), permanent: true);

    await Get.putAsync(
      () => SessionService(
        authRepository: AuthRepositoryImpl(
          AuthRemoteDataSourceImpl(
            unauthorizedClient: Get.find<UnauthorizedClient>(),
            authorizedClient: Get.find<AuthorizedClient>(),
          ),
        ),
      ).init(),
      permanent: true,
    );

    // Initialize Location Controller globally
    LocationBinding.init();

    // Initialize Bank Controller globally
    BankBinding.init();

    // Initialize Cart Controller globally
    CartBinding.init();
  }
}
