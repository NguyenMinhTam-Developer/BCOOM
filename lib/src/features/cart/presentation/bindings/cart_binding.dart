import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/cart_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../../address/data/datasources/address_remote_data_source.dart';
import '../../../address/data/repositories/address_repository_impl.dart';
import '../../../address/domain/repositories/address_repository.dart';
import '../../../address/domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/add_product_to_cart_usecase.dart';
import '../../domain/usecases/apply_voucher_usecase.dart';
import '../../domain/usecases/cancel_cart_usecase.dart';
import '../../domain/usecases/confirm_placing_order_usecase.dart';
import '../../domain/usecases/get_cart_info_usecase.dart';
import '../../domain/usecases/get_platform_coupons_usecase.dart';
import '../../domain/usecases/get_seller_coupons_usecase.dart';
import '../../domain/usecases/reset_cart_usecase.dart';
import '../../domain/usecases/select_shipping_address_usecase.dart';
import '../../domain/usecases/update_cart_usecase.dart';
import '../../domain/usecases/update_product_quantity_usecase.dart';
import '../../domain/usecases/update_variant_in_cart_usecase.dart';
import '../controllers/cart_controller.dart';

class CartBinding {
  static void init() {
    // Initialize data source
    Get.lazyPut<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<CartRepository>(
      () => CartRepositoryImpl(
        Get.find<CartRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use cases
    Get.lazyPut<GetCartInfoUseCase>(
      () => GetCartInfoUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ConfirmPlacingOrderUseCase>(
      () => ConfirmPlacingOrderUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ApplyVoucherUseCase>(
      () => ApplyVoucherUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<SelectShippingAddressUseCase>(
      () => SelectShippingAddressUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<AddProductToCartUseCase>(
      () => AddProductToCartUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CancelCartUseCase>(
      () => CancelCartUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ResetCartUseCase>(
      () => ResetCartUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetPlatformCouponsUseCase>(
      () => GetPlatformCouponsUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetSellerCouponsUseCase>(
      () => GetSellerCouponsUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<UpdateCartUseCase>(
      () => UpdateCartUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<UpdateProductQuantityUseCase>(
      () => UpdateProductQuantityUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<UpdateVariantInCartUseCase>(
      () => UpdateVariantInCartUseCase(
        cartRepository: Get.find<CartRepository>(),
      ),
      fenix: true,
    );

    // Initialize address data source and repository if not already registered
    if (!Get.isRegistered<AddressRemoteDataSource>()) {
      Get.lazyPut<AddressRemoteDataSource>(
        () => AddressRemoteDataSourceImpl(
          authorizedClient: Get.find<AuthorizedClient>(),
        ),
        fenix: true,
      );
    }

    if (!Get.isRegistered<AddressRepository>()) {
      Get.lazyPut<AddressRepository>(
        () => AddressRepositoryImpl(
          Get.find<AddressRemoteDataSource>(),
        ),
        fenix: true,
      );
    }

    Get.lazyPut<GetAddressesUseCase>(
      () => GetAddressesUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller as permanent global instance
    Get.put<CartController>(
      CartController(
        getCartInfoUseCase: Get.find<GetCartInfoUseCase>(),
        confirmPlacingOrderUseCase: Get.find<ConfirmPlacingOrderUseCase>(),
        applyVoucherUseCase: Get.find<ApplyVoucherUseCase>(),
        selectShippingAddressUseCase: Get.find<SelectShippingAddressUseCase>(),
        addProductToCartUseCase: Get.find<AddProductToCartUseCase>(),
        cancelCartUseCase: Get.find<CancelCartUseCase>(),
        resetCartUseCase: Get.find<ResetCartUseCase>(),
        getPlatformCouponsUseCase: Get.find<GetPlatformCouponsUseCase>(),
        getSellerCouponsUseCase: Get.find<GetSellerCouponsUseCase>(),
        updateCartUseCase: Get.find<UpdateCartUseCase>(),
        updateProductQuantityUseCase: Get.find<UpdateProductQuantityUseCase>(),
        getAddressesUseCase: Get.find<GetAddressesUseCase>(),
      ),
      permanent: true,
    );
  }
}
