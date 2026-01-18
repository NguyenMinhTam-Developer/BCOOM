import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/viewed_product_remote_data_source.dart';
import '../../data/repositories/viewed_product_repository_impl.dart';
import '../../domain/repositories/viewed_product_repository.dart';
import '../../domain/usecases/get_viewed_products_usecase.dart';
import '../controllers/viewed_product_controller.dart';

class ViewedProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewedProductRemoteDataSource>(
      () => ViewedProductRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ViewedProductRepository>(
      () => ViewedProductRepositoryImpl(
        Get.find<ViewedProductRemoteDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetViewedProductsUseCase>(
      () => GetViewedProductsUseCase(
        repository: Get.find<ViewedProductRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ViewedProductController>(
      () => ViewedProductController(
        getViewedProductsUseCase: Get.find<GetViewedProductsUseCase>(),
      ),
    );
  }
}

