import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../data/datasources/page_remote_data_source.dart';
import '../../data/repositories/page_repository_impl.dart';
import '../../domain/repositories/page_repository.dart';
import '../../domain/usecases/get_page_usecase.dart';
import '../controllers/page_view_controller.dart';

class PageViewBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize remote data source
    Get.lazyPut<PageRemoteDataSource>(
      () => PageRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<PageRepository>(
      () => PageRepositoryImpl(
        remoteDataSource: Get.find<PageRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use case
    Get.lazyPut<GetPageUseCase>(
      () => GetPageUseCase(
        repository: Get.find<PageRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller
    Get.lazyPut<PageViewController>(
      () => PageViewController(
        getPageUseCase: Get.find<GetPageUseCase>(),
      ),
    );
  }
}
