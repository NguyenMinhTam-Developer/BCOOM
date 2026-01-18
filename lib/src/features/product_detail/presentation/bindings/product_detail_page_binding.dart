import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../data/repositories/product_detail_repository_impl.dart';
import '../../data/source/product_detail_remote_data_source.dart';
import '../../domain/repositories/product_detail_repository.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_related_products_usecase.dart';
import '../controllers/product_detail_controller.dart';
import '../../../cart/data/datasources/cart_remote_data_source.dart';
import '../../../cart/data/repositories/cart_repository_impl.dart';
import '../../../cart/domain/repositories/cart_repository.dart';
import '../../../cart/domain/usecases/add_product_to_cart_usecase.dart';

class ProductDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailRemoteDataSource>(
      () => ProductDetailRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
    );

    Get.lazyPut<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl(
        Get.find<ProductDetailRemoteDataSource>(),
      ),
    );

    Get.lazyPut<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(
        productDetailRepository: Get.find<ProductDetailRepository>(),
      ),
    );

    Get.lazyPut<GetRelatedProductsUseCase>(
      () => GetRelatedProductsUseCase(
        productDetailRepository: Get.find<ProductDetailRepository>(),
      ),
    );

    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(
        getProductDetailUseCase: Get.find<GetProductDetailUseCase>(),
        getRelatedProductsUseCase: Get.find<GetRelatedProductsUseCase>(),
        addProductToCartUseCase: Get.isRegistered<AddProductToCartUseCase>()
            ? Get.find<AddProductToCartUseCase>()
            : null,
      ),
    );
  }
}
