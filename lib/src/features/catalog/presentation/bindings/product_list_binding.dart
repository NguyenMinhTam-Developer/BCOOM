import 'package:bcoom/src/core/di/tdd_binding.dart';
import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../../home/domain/repositories/home_repository.dart';
import '../../../home/domain/usecases/get_collection_list_usecase.dart';
import '../../data/datasources/catalog_remote_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_product_list_usecase.dart';
import '../../domain/usecases/get_product_sub_side_bar_usecase.dart';
import '../controllers/product_list_controller.dart';

class ProductListBinding extends TddBinding {
  @override
  void initController() {
    Get.lazyPut<ProductListController>(
      () => ProductListController(
        getProductListUseCase: Get.find<GetProductListUseCase>(),
        getCollectionListUseCase: Get.find<GetCollectionListUseCase>(),
        getProductSubSideBarUseCase: Get.find<GetProductSubSideBarUseCase>(),
      ),
    );
  }

  @override
  void initDataSource() {
    Get.lazyPut<CatalogRemoteDataSource>(
      () => CatalogRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
    );
  }

  @override
  void initRepository() {
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        Get.find<CatalogRemoteDataSource>(),
      ),
    );
  }

  @override
  void initUseCase() {
    Get.lazyPut<GetProductListUseCase>(
      () => GetProductListUseCase(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );

    Get.lazyPut<GetCollectionListUseCase>(
      () => GetCollectionListUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetProductSubSideBarUseCase>(
      () => GetProductSubSideBarUseCase(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );
  }
}
