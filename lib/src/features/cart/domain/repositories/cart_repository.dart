import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_info_entity.dart';
import '../entities/coupon_entity.dart';
import '../entities/order_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartInfoEntity>> getCartInfo();

  Future<Either<Failure, CartOrderEntity>> confirmPlacingOrder({
    required List<Map<String, int>> products,
    String? remarks,
    int hasExportEinvoice = 0,
    required String paymentMethod,
    required Map<String, String> shippingAddress,
    dynamic einvoice,
  });

  Future<Either<Failure, CartInfoEntity>> applyVoucher({
    required String voucherCode,
  });

  Future<Either<Failure, CartInfoEntity>> selectShippingAddress({
    required int addressId,
  });

  Future<Either<Failure, CartInfoEntity>> addProductToCart({
    required int productId,
    int variantId = 0,
    required int quantity,
  });

  Future<Either<Failure, CartInfoEntity>> updateProductQuantity({
    required int productId,
    required int variantId,
    required int quantity,
  });

  Future<Either<Failure, CartInfoEntity>> updateVariantInCart({
    required int productId,
    required int variantId,
    required int quantity,
  });

  Future<Either<Failure, void>> cancelCart();

  Future<Either<Failure, void>> resetCart();

  Future<Either<Failure, CartInfoEntity>> updateCart({
    required List<Map<String, int>> products,
  });

  Future<Either<Failure, PlatformCouponsEntity>> getPlatformCoupons();

  Future<Either<Failure, SellerCouponsEntity>> getSellerCoupons({
    required int sellerId,
    required int totalProduct,
    required List<int> productIds,
  });
}
