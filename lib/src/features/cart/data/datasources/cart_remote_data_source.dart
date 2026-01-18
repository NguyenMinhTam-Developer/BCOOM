import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/cart_info_entity.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../models/cart_info_model.dart';
import '../models/coupon_model.dart';
import '../models/order_model.dart';

abstract class CartRemoteDataSource {
  Future<CartInfoEntity> getCartInfo();

  Future<CartOrderEntity> confirmPlacingOrder({
    required List<Map<String, int>> products,
    String? remarks,
    int hasExportEinvoice = 0,
    required String paymentMethod,
    required Map<String, String> shippingAddress,
    dynamic einvoice,
  });

  Future<CartInfoEntity> applyVoucher({
    required String voucherCode,
  });

  Future<CartInfoEntity> selectShippingAddress({
    required int addressId,
  });

  Future<CartInfoEntity> addProductToCart({
    required int productId,
    int variantId = 0,
    required int quantity,
  });

  Future<CartInfoEntity> updateProductQuantity({
    required int productId,
    required int variantId,
    required int quantity,
  });

  Future<CartInfoEntity> updateVariantInCart({
    required int productId,
    required int variantId,
    required int quantity,
  });

  Future<void> cancelCart();

  Future<void> resetCart();

  Future<CartInfoEntity> updateCart({
    required List<Map<String, int>> products,
  });

  Future<PlatformCouponsEntity> getPlatformCoupons();

  Future<SellerCouponsEntity> getSellerCoupons({
    required int sellerId,
    required int totalProduct,
    required List<int> productIds,
  });
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  CartRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<CartInfoEntity> getCartInfo() async {
    final response = await _authorizedClient.post(
      '/api/customers/cart',
      {},
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartOrderEntity> confirmPlacingOrder({
    required List<Map<String, int>> products,
    String? remarks,
    int hasExportEinvoice = 0,
    required String paymentMethod,
    required Map<String, String> shippingAddress,
    dynamic einvoice,
  }) async {
    final body = <String, dynamic>{
      'products': products,
      'has_export_einvoice': hasExportEinvoice,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      '_guard': 'customer',
    };

    if (remarks != null && remarks.isNotEmpty) {
      body['remarks'] = remarks;
    } else {
      body['remarks'] = null;
    }

    if (einvoice != null) {
      body['einvoice'] = einvoice;
    } else {
      body['einvoice'] = null;
    }

    final response = await _authorizedClient.post(
      '/api/customers/cart/create',
      body,
    );

    RemoteDataSource.handleResponse(response);

    return OrderModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartInfoEntity> applyVoucher({
    required String voucherCode,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/apply-voucher',
      {
        'voucher_code': voucherCode,
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartInfoEntity> selectShippingAddress({
    required int addressId,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/shipping-address',
      {
        'address_id': addressId,
        'distance': 100,
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartInfoEntity> addProductToCart({
    required int productId,
    int variantId = 0,
    required int quantity,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/product',
      {
        'product_id': productId,
        'variant_id': variantId,
        'quantity': quantity,
        'type': 'addToCart',
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartInfoEntity> updateProductQuantity({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/product',
      {
        'product_id': productId,
        'variant_id': variantId,
        'quantity': quantity,
        'type': 'updateQuantityInCart',
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CartInfoEntity> updateVariantInCart({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/product',
      {
        'product_id': productId,
        'variant_id': variantId,
        'quantity': quantity,
        'type': 'updateVariantInCart',
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> cancelCart() async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/cancel',
      {},
    );

    RemoteDataSource.handleResponse(response);
  }

  @override
  Future<void> resetCart() async {
    final response = await _authorizedClient.post(
      '/api/customers/cart/reset',
      {},
    );

    RemoteDataSource.handleResponse(response);
  }

  @override
  Future<CartInfoEntity> updateCart({
    required List<Map<String, int>> products,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/cart',
      {
        'products': products,
      },
    );

    RemoteDataSource.handleResponse(response);

    return CartInfoModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<PlatformCouponsEntity> getPlatformCoupons() async {
    final response = await _authorizedClient.post(
      '/api/customers/vouchers/platform-coupons',
      {},
    );

    RemoteDataSource.handleResponse(response);

    return PlatformCouponsModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<SellerCouponsEntity> getSellerCoupons({
    required int sellerId,
    required int totalProduct,
    required List<int> productIds,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/vouchers/seller-coupons',
      {
        'total_product': totalProduct,
        'product_ids': productIds,
      },
      query: {
        'seller_id': sellerId.toString(),
      },
    );

    RemoteDataSource.handleResponse(response);

    return SellerCouponsModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }
}
