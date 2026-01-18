import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../../catalog/domain/usecases/get_product_sub_side_bar_usecase.dart';
import '../../../catalog/presentation/controllers/catalog_controller.dart';
import '../../../catalog/domain/usecases/get_product_side_bar_usecase.dart';
import '../../../sales/presentation/controllers/sales_controller.dart';
import '../../../order/presentation/bindings/order_binding.dart';
import '../../../wishlist/presentation/bindings/wishlist_binding.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../data/source/home_remote_data_source.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_brand_list_usecase.dart';
import '../../domain/usecases/get_collection_list_usecase.dart';
import '../../domain/usecases/get_home_product_usecase.dart';
import '../../domain/usecases/get_landing_page_usecase.dart';
import '../../domain/usecases/get_raw_landing_page_usecase.dart';
import '../controllers/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
    );

    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeRemoteDataSource>(),
      ),
    );

    Get.lazyPut<GetLandingPageUseCase>(
      () => GetLandingPageUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetRawLandingPageUseCase>(
      () => GetRawLandingPageUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetBrandListUseCase>(
      () => GetBrandListUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetHomeProductUseCase>(
      () => GetHomeProductUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<GetCollectionListUseCase>(
      () => GetCollectionListUseCase(
        homeRepository: Get.find<HomeRepository>(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        getLandingPageUseCase: Get.find<GetLandingPageUseCase>(),
        getRawLandingPageUseCase: Get.find<GetRawLandingPageUseCase>(),
        getCollectionListUseCase: Get.find<GetCollectionListUseCase>(),
        getBrandListUseCase: Get.find<GetBrandListUseCase>(),
      ),
    );

    Get.lazyPut<CatalogController>(
      () => CatalogController(
        getProductSideBarUseCase: Get.find<GetProductSideBarUseCase>(),
        getProductSubSideBarUseCase: Get.find<GetProductSubSideBarUseCase>(),
        getBrandListUseCase: Get.find<GetBrandListUseCase>(),
      ),
    );
    Get.lazyPut<SalesController>(() => SalesController());
    
    // Initialize OrderBinding for order feature
    OrderBinding().dependencies();

    // Initialize Wishlist as a global feature when entering Home
    WishlistBinding.init();
  }
}
