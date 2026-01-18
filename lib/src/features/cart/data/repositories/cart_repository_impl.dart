import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CartInfoEntity>> getCartInfo() async {
    try {
      final response = await remoteDataSource.getCartInfo();
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi tải thông tin giỏ hàng',
        message: e.description ?? 'Lỗi tải thông tin giỏ hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartOrderEntity>> confirmPlacingOrder({
    required List<Map<String, int>> products,
    String? remarks,
    int hasExportEinvoice = 0,
    required String paymentMethod,
    required Map<String, String> shippingAddress,
    dynamic einvoice,
  }) async {
    try {
      final response = await remoteDataSource.confirmPlacingOrder(
        products: products,
        remarks: remarks,
        hasExportEinvoice: hasExportEinvoice,
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
        einvoice: einvoice,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi xác nhận đặt hàng',
        message: e.description ?? 'Lỗi xác nhận đặt hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> applyVoucher({
    required String voucherCode,
  }) async {
    try {
      final response = await remoteDataSource.applyVoucher(
        voucherCode: voucherCode,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi áp dụng mã giảm giá',
        message: e.description ?? 'Lỗi áp dụng mã giảm giá',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> selectShippingAddress({
    required int addressId,
  }) async {
    try {
      final response = await remoteDataSource.selectShippingAddress(
        addressId: addressId,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi chọn địa chỉ giao hàng',
        message: e.description ?? 'Lỗi chọn địa chỉ giao hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> addProductToCart({
    required int productId,
    int variantId = 0,
    required int quantity,
  }) async {
    try {
      final response = await remoteDataSource.addProductToCart(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi thêm sản phẩm vào giỏ hàng',
        message: e.description ?? 'Lỗi thêm sản phẩm vào giỏ hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> updateProductQuantity({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    try {
      final response = await remoteDataSource.updateProductQuantity(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi cập nhật số lượng sản phẩm',
        message: e.description ?? 'Lỗi cập nhật số lượng sản phẩm',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> updateVariantInCart({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    try {
      final response = await remoteDataSource.updateVariantInCart(
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi cập nhật biến thể sản phẩm',
        message: e.description ?? 'Lỗi cập nhật biến thể sản phẩm',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> cancelCart() async {
    try {
      await remoteDataSource.cancelCart();
      return const Right(null);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi hủy giỏ hàng',
        message: e.description ?? 'Lỗi hủy giỏ hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> resetCart() async {
    try {
      await remoteDataSource.resetCart();
      return const Right(null);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi xóa tất cả sản phẩm',
        message: e.description ?? 'Lỗi xóa tất cả sản phẩm',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, CartInfoEntity>> updateCart({
    required List<Map<String, int>> products,
  }) async {
    try {
      final response = await remoteDataSource.updateCart(
        products: products,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi cập nhật giỏ hàng',
        message: e.description ?? 'Lỗi cập nhật giỏ hàng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, PlatformCouponsEntity>> getPlatformCoupons() async {
    try {
      final response = await remoteDataSource.getPlatformCoupons();
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi tải mã giảm giá nền tảng',
        message: e.description ?? 'Lỗi tải mã giảm giá nền tảng',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, SellerCouponsEntity>> getSellerCoupons({
    required int sellerId,
    required int totalProduct,
    required List<int> productIds,
  }) async {
    try {
      final response = await remoteDataSource.getSellerCoupons(
        sellerId: sellerId,
        totalProduct: totalProduct,
        productIds: productIds,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(CartFailure(
        title: 'Lỗi tải mã giảm giá người bán',
        message: e.description ?? 'Lỗi tải mã giảm giá người bán',
      ));
    } catch (e) {
      return Left(CartFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
