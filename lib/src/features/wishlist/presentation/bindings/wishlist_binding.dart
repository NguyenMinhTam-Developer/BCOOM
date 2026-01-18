import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/wishlist_remote_data_source.dart';
import '../../data/repositories/wishlist_repository_impl.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../domain/usecases/add_products_to_wishlist_usecase.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/remove_products_from_wishlist_usecase.dart';
import '../controllers/wishlist_controller.dart';

class WishlistBinding {
  static void init() {
    if (!Get.isRegistered<WishlistRemoteDataSource>()) {
      Get.lazyPut<WishlistRemoteDataSource>(
        () => WishlistRemoteDataSourceImpl(
          authorizedClient: Get.find<AuthorizedClient>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<WishlistRepository>()) {
      Get.lazyPut<WishlistRepository>(
        () => WishlistRepositoryImpl(
          Get.find<WishlistRemoteDataSource>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<GetWishlistUseCase>()) {
      Get.lazyPut<GetWishlistUseCase>(
        () => GetWishlistUseCase(
          wishlistRepository: Get.find<WishlistRepository>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<AddProductsToWishlistUseCase>()) {
      Get.lazyPut<AddProductsToWishlistUseCase>(
        () => AddProductsToWishlistUseCase(
          wishlistRepository: Get.find<WishlistRepository>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<RemoveProductsFromWishlistUseCase>()) {
      Get.lazyPut<RemoveProductsFromWishlistUseCase>(
        () => RemoveProductsFromWishlistUseCase(
          wishlistRepository: Get.find<WishlistRepository>(),
        ),
        fenix: true,
      );
    }

    // Permanent global controller (initialized when Home is entered)
    if (!Get.isRegistered<WishlistController>()) {
      Get.put<WishlistController>(
        WishlistController(
          getWishlistUseCase: Get.find<GetWishlistUseCase>(),
          addProductsToWishlistUseCase: Get.find<AddProductsToWishlistUseCase>(),
          removeProductsFromWishlistUseCase: Get.find<RemoveProductsFromWishlistUseCase>(),
        ),
        permanent: true,
      );
    }
  }
}

