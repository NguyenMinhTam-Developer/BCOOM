import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../../faq/data/datasources/faq_remote_data_source.dart';
import '../../../faq/data/repositories/faq_repository_impl.dart';
import '../../../faq/domain/repositories/faq_repository.dart';
import '../../../faq/domain/usecases/get_all_faqs_usecase.dart';
import '../controllers/customer_support_controller.dart';

class CustomerSupportBinding extends Bindings {
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
    Get.lazyPut<GetAllFaqsUseCase>(
      () => GetAllFaqsUseCase(
        repository: Get.find<FaqRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller
    Get.lazyPut<CustomerSupportController>(
      () => CustomerSupportController(
        getAllFaqsUseCase: Get.find<GetAllFaqsUseCase>(),
      ),
    );
  }
}
