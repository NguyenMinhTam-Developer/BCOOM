import '../../features/auth/domain/entities/auth_response.dart';

abstract class Failure {
  final String title;
  final String message;
  const Failure({required this.title, required this.message});
}

class InputValidationFailure extends Failure {
  const InputValidationFailure({super.title = 'Dữ liệu không hợp lệ', required super.message});
}

abstract class AuthFailure extends Failure {
  const AuthFailure({super.title = 'Lỗi xác thực tài khoản', required super.message});
}

class EmailNotVerifiedFailure extends AuthFailure {
  final AuthResponse authResponse;

  const EmailNotVerifiedFailure({required super.title, required super.message, required this.authResponse});
}

class UploadFileFailure extends Failure {
  const UploadFileFailure({super.title = "Lỗi tải file", required super.message});
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure({required super.title, required super.message});
}

class HttpFailure extends AuthFailure {
  const HttpFailure({required super.title, required super.message});
}

class ServerFailure extends AuthFailure {
  const ServerFailure({required super.title, required super.message});
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure({required super.title, required super.message});
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({required super.title, required super.message});
}

//========= PCODE =========

class PcodeFailure extends Failure {
  const PcodeFailure({required super.title, required super.message});
}

class PcodeRequiredFailure extends PcodeFailure {
  const PcodeRequiredFailure({required super.title, required super.message});
}

class PcodeNotFoundFailure extends PcodeFailure {
  const PcodeNotFoundFailure({required super.title, required super.message});
}

class PcodeInvalidFailure extends PcodeFailure {
  const PcodeInvalidFailure({required super.title, required super.message});
}

class PcodeExpiredFailure extends PcodeFailure {
  const PcodeExpiredFailure({required super.title, required super.message});
}

//========= HOME =========

class HomeFailure extends Failure {
  const HomeFailure({super.title = 'Lỗi trang chủ', required super.message});
}

//========= SEARCH =========

class SearchFailure extends Failure {
  const SearchFailure({super.title = 'Lỗi tìm kiếm', required super.message});
}

//========= PRODUCT DETAIL =========

class ProductDetailFailure extends Failure {
  const ProductDetailFailure({super.title = 'Lỗi chi tiết sản phẩm', required super.message});
}

//========= CATALOG =========

class CatalogFailure extends Failure {
  const CatalogFailure({super.title = 'Lỗi danh mục', required super.message});
}

//========= CART =========

class CartFailure extends Failure {
  const CartFailure({super.title = 'Lỗi giỏ hàng', required super.message});
}

//========= ADDRESS =========

class AddressFailure extends Failure {
  const AddressFailure({super.title = 'Lỗi địa chỉ', required super.message});
}

//========= BANK =========

class BankFailure extends Failure {
  const BankFailure({super.title = 'Lỗi ngân hàng', required super.message});
}

//========= LOCATION =========

class LocationFailure extends Failure {
  const LocationFailure({super.title = 'Lỗi địa điểm', required super.message});
}

//========= FAQ =========

class FaqFailure extends Failure {
  const FaqFailure({super.title = 'Lỗi FAQ', required super.message});
}

//========= WISHLIST =========

class WishlistFailure extends Failure {
  const WishlistFailure({super.title = 'Lỗi danh sách yêu thích', required super.message});
}

//========= VIEWED PRODUCT =========

class ViewedProductFailure extends Failure {
  const ViewedProductFailure({super.title = 'Lỗi sản phẩm đã xem', required super.message});
}
