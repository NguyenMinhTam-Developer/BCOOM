import 'package:get/get.dart';

import '../../../../core/di/tdd_binding.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../../home/data/repositories/home_repository_impl.dart';
import '../../../home/data/source/home_remote_data_source.dart';
import '../../../home/domain/repositories/home_repository.dart';
import '../../../home/domain/usecases/get_brand_list_usecase.dart';
import '../../../home/domain/usecases/get_collection_list_usecase.dart';
import '../../data/datasources/catalog_remote_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_product_list_usecase.dart';
import '../../domain/usecases/get_product_side_bar_usecase.dart';
import '../../domain/usecases/get_product_sub_side_bar_usecase.dart';
import '../controllers/catalog_controller.dart';

class CatalogPageBinding extends TddBinding {
  @override
  void initDataSource() {
    Get.lazyPut<CatalogRemoteDataSource>(
      () => CatalogRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
    );

    Get.lazyPut<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
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
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeRemoteDataSource>(),
      ),
    );
  }

  @override
  void initUseCase() {
    Get.lazyPut<GetProductSideBarUseCase>(
      () => GetProductSideBarUseCase(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );

    Get.lazyPut<GetProductSubSideBarUseCase>(
      () => GetProductSubSideBarUseCase(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );

    Get.lazyPut<GetCollectionListUseCase>(
      () => GetCollectionListUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetBrandListUseCase>(
      () => GetBrandListUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetProductListUseCase>(
      () => GetProductListUseCase(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.lazyPut<CatalogController>(
      () => CatalogController(
        getProductSideBarUseCase: Get.find<GetProductSideBarUseCase>(),
        getProductSubSideBarUseCase: Get.find<GetProductSubSideBarUseCase>(),
        getBrandListUseCase: Get.find<GetBrandListUseCase>(),
      ),
    );
  }
}
