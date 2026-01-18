import 'package:get/get.dart';

import '../../features/cart/presentation/pages/select_shipping_address_page.dart';

class AppPageNames {
  static const String initial = '/';

  static const String splash = '/';

  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String roleSelection = '/role-selection';
  static const String saleRegister = '/sale-register';
  static const String profileCompletion = '/profile-completion';
  static const String accountVerification = '/account-verification';
  static const String myAccount = '/my-account';
  static const String forgotPassword = '/forgot-password';
  static const String genericOtpVerification = '/generic-otp-verification';
  static const String resetPassword = '/reset-password';
  static const String changePassword = '/change-password';
  static const String myPointHistory = '/my-point-history';
  static const String myGifts = '/my-gifts';
  static const String myCourse = '/my-course';
  static const String addresses = '/addresses';
  static const String addressCreate = '/addresses/create';
  static const String addressEdit = '/addresses/:id/edit';
  static const String selectShippingAddress = '/checkout/select-address';
  static const String banks = '/banks';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  // FAQ
  static const String faqList = '/faq-list';
  static const String faqDetail = '/faq-detail';

  // Customer Support
  static const String customerSupport = '/customer-support';

  // Page View
  static const String pageView = '/page';

  // Home
  static const String home = '/home';

  // Catalog
  static const String catalogSearch = '/catalog-search';
  static const String productDetail = '/product/:name_slug';
  static const String wishlist = '/wishlist';
  static const String viewedProducts = '/viewed-products';

  // Policies
  static String get privacyPolicyRoute => '/privacy-policy';
  static String get termsOfServiceRoute => '/terms-of-service';
  static String get appInformationPolicyRoute => '/app-information-policy';

  static const String profile = '/profile';
  static const String products = '/products';

  // Aikya
  static const String _aikya = '/aikya';

  static String trimParentRoute({required String parentRoute, required String childRoute}) {
    return childRoute.replaceFirst(parentRoute, '');
  }

  static void navigateToHome() => Get.offAllNamed(home);
  static void navigateToOnboarding() => Get.offAllNamed(onboarding);
  static void navigateToLogin() => Get.offAllNamed(login);
  static void navigateToProfile() => Get.offAllNamed(profile);
  static void navigateToProducts() => Get.offAllNamed(products);

  static void back() => Get.back();

  static void navigateToForgotPassword() => Get.toNamed(forgotPassword);
  static void navigateToGenericOtpVerification({
    required String email,
    required String token,
    void Function(String otp)? onSuccess,
    void Function(String error)? onFailure,
  }) =>
      Get.toNamed(
        genericOtpVerification,
        parameters: {'email': email, 'token': token},
        arguments: {'onSuccess': onSuccess, 'onFailure': onFailure},
      );
  static void navigateToResetPassword({
    required String otp,
    required String token,
    void Function()? onSuccess,
    void Function(String error)? onFailure,
  }) =>
      Get.toNamed(
        resetPassword,
        parameters: {'otp': otp, 'token': token},
        arguments: {'onSuccess': onSuccess, 'onFailure': onFailure},
      );

  static void navigateToChangePassword() => Get.toNamed(changePassword);
  static void navigateToMyGifts() => Get.toNamed(myGifts);
  static void navigateToMyCourse() => Get.toNamed(myCourse);

  static void navigateToMyPointHistory() => Get.toNamed(myPointHistory);

  static void navigateToAikya() => Get.toNamed(_aikya);

  static void navigateToProductDetail({required String nameSlug}) => Get.toNamed(
        productDetail.replaceAll(':name_slug', nameSlug),
      );

  static void navigateToWishlist() => Get.toNamed(wishlist);
  static void navigateToViewedProducts() => Get.toNamed(viewedProducts);

  static void navigateToAddresses() => Get.toNamed(addresses);
  static Future<int?> navigateToSelectShippingAddress() => SelectShippingAddressPage.navigateTo();

  static void navigateToBanks() => Get.toNamed(banks);
  static void navigateToOrders() => Get.toNamed(orders);
  static void navigateToOrderDetail({required int orderId}) => Get.toNamed(
        orderDetail.replaceAll(':id', orderId.toString()),
      );
  static void navigateToCart() => Get.toNamed(cart);
  static void navigateToCheckout() => Get.toNamed(checkout);

  static void navigateToFaqList() => Get.toNamed(faqList);

  static void navigateToCustomerSupport() => Get.toNamed(customerSupport);

  static void navigateToPageView({required String slug}) => Get.toNamed(
        pageView,
        parameters: {'slug': slug},
      );
}
