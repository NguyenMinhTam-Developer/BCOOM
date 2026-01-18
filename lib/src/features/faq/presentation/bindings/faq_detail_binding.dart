import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../data/datasources/faq_remote_data_source.dart';
import '../../data/repositories/faq_repository_impl.dart';
import '../../domain/repositories/faq_repository.dart';
import '../../domain/usecases/get_faqs_usecase.dart';
import '../controllers/faq_detail_controller.dart';

class FaqDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize remote data source
    Get.lazyPut<FaqRemoteDataSource>(
      () => FaqRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<FaqRepository>(
      () => FaqRepositoryImpl(
        remoteDataSource: Get.find<FaqRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use case
    Get.lazyPut<GetFaqsUseCase>(
      () => GetFaqsUseCase(
        repository: Get.find<FaqRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller
    Get.lazyPut<FaqDetailController>(
      () => FaqDetailController(
        getFaqsUseCase: Get.find<GetFaqsUseCase>(),
      ),
    );
  }
}
