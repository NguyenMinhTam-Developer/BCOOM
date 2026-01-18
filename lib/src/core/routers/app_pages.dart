import '../../features/catalog/presentation/bindings/catalog_page_binding.dart';
import '../../features/catalog/presentation/bindings/product_list_binding.dart';
import '../../features/catalog/presentation/pages/product_list_page.dart';
import '../../features/search/presentation/bindings/search_page_binding.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/product_detail/presentation/bindings/product_detail_page_binding.dart';
import '../../features/product_detail/presentation/pages/product_detail_page.dart';
import '../../features/product_detail/presentation/pages/product_information_page.dart';
import '../../features/faq/presentation/bindings/faq_list_binding.dart';
import '../../features/faq/presentation/bindings/faq_detail_binding.dart';
import '../../features/faq/presentation/pages/faq_list_page.dart';
import '../../features/faq/presentation/pages/faq_detail_page.dart';
import '../../features/page_view/presentation/bindings/page_view_binding.dart';
import '../../features/page_view/presentation/pages/page_view_page.dart';
import '../../features/wishlist/presentation/pages/wishlist_page.dart';
import '../../features/viewed_product/presentation/bindings/viewed_product_binding.dart';
import '../../features/viewed_product/presentation/pages/viewed_product_page.dart';

import '../services/session/session_guard.dart';
import '../services/session/auth_guard.dart';
import '../../features/address/presentation/bindings/address_binding.dart';
import '../../features/address/presentation/bindings/create_address_binding.dart';
import '../../features/address/presentation/bindings/update_address_binding.dart';
import '../../features/address/presentation/pages/address_page.dart';
import '../../features/address/presentation/pages/create_address_page.dart';
import '../../features/address/presentation/pages/update_address_page.dart';
import '../../features/bank/presentation/pages/bank_page.dart';
import '../../features/order/presentation/bindings/order_binding.dart';
import '../../features/order/presentation/pages/order_detail_page.dart';
import '../../features/order/presentation/pages/order_list_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/checkout_page.dart';
import '../../features/cart/presentation/pages/select_shipping_address_page.dart';
import '../../features/auth/presentation/bindings/account_verification_binding.dart';
import '../../features/auth/presentation/bindings/change_password_binding.dart';
import '../../features/auth/presentation/bindings/customer_support_binding.dart';
import '../../features/auth/presentation/bindings/forgot_password_page_binding.dart';
import '../../features/auth/presentation/bindings/generic_otp_verification_binding.dart';
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/bindings/my_account_binding.dart';
import '../../features/auth/presentation/bindings/profile_completion_binding.dart';
import '../../features/auth/presentation/bindings/register_binding.dart';
import '../../features/auth/presentation/bindings/reset_password_binding.dart';
import '../../features/auth/presentation/bindings/role_selection_binding.dart';
import '../../features/auth/presentation/bindings/sale_register_binding.dart';
import '../../features/auth/presentation/pages/account_verification_page.dart';
import '../../features/auth/presentation/pages/change_password_page.dart';
import '../../features/auth/presentation/pages/customer_support_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/generic_otp_verification_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/my_account_page.dart';
import '../../features/auth/presentation/pages/profile_completion_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/role_selection_page.dart';
import '../../features/auth/presentation/pages/sale_register_page.dart';
import 'package:get/get.dart';

import '../../features/home/presentation/bindings/home_page_binding.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/bindings/onboarding_page_binding.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/bindings/splash_page_binding.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_page_names.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppPageNames.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppPageNames.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingPageBinding(),
    ),
    // Home page with bottom navigation
    GetPage(
      name: AppPageNames.home,
      page: () => const HomePage(),
      // binding: HomePageBinding(),
      bindings: [
        HomePageBinding(),
        CatalogPageBinding(),
      ],
      middlewares: [SessionGuard()],
    ),
    // ...AuthRouter.routes,
    ...[
      GetPage(
        name: AppPageNames.login,
        page: () => const LoginPage(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: AppPageNames.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding(),
      ),
      GetPage(
        name: AppPageNames.roleSelection,
        page: () => const RoleSelectionPage(),
        binding: RoleSelectionBinding(),
      ),
      GetPage(
        name: AppPageNames.saleRegister,
        page: () => const SaleRegisterPage(),
        binding: SaleRegisterBinding(),
      ),
      GetPage(
        name: AppPageNames.accountVerification,
        page: () => const AccountVerificationPage(),
        binding: AccountVerificationBinding(),
      ),
      GetPage(
        name: AppPageNames.profileCompletion,
        page: () => const ProfileCompletionPage(),
        binding: ProfileCompletionBinding(),
      ),
      GetPage(
        name: AppPageNames.myAccount,
        page: () => const MyAccountPage(),
        binding: MyAccountBinding(),
      ),
      GetPage(
        name: AppPageNames.forgotPassword,
        page: () => const ForgotPasswordPage(),
        binding: ForgotPasswordPageBinding(),
      ),
      GetPage(
        name: AppPageNames.genericOtpVerification,
        page: () => const GenericOtpVerificationPage(),
        binding: GenericOtpVerificationBinding(),
      ),
      GetPage(
        name: AppPageNames.resetPassword,
        page: () => const ResetPasswordPage(),
        binding: ResetPasswordBinding(),
      ),
      GetPage(
        name: AppPageNames.changePassword,
        page: () => const ChangePasswordPage(),
        binding: ChangePasswordBinding(),
      ),
      GetPage(
        name: AppPageNames.addresses,
        page: () => const AddressPage(),
        binding: AddressBinding(),
        middlewares: [AuthGuard()],
      ),
      GetPage(
        name: AppPageNames.addressCreate,
        page: () => const CreateAddressPage(),
        binding: CreateAddressBinding(),
        middlewares: [AuthGuard()],
      ),
      GetPage(
        name: AppPageNames.addressEdit,
        page: () => const UpdateAddressPage(),
        binding: UpdateAddressBinding(),
        middlewares: [AuthGuard()],
      ),
      GetPage(
        name: AppPageNames.banks,
        page: () => const BankPage(),
        middlewares: [AuthGuard()],
      ),
      GetPage(
        name: AppPageNames.orders,
        page: () => const OrderListPage(),
        binding: OrderBinding(),
        middlewares: [AuthGuard()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: AppPageNames.orderDetail,
        page: () => const OrderDetailPage(),
        binding: OrderBinding(),
        middlewares: [AuthGuard()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: AppPageNames.cart,
        page: () => const CartPage(),
        middlewares: [AuthGuard()],
      ),
      GetPage(
        name: AppPageNames.checkout,
        page: () => const CheckoutPage(),
        middlewares: [AuthGuard()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: AppPageNames.selectShippingAddress,
        page: () => const SelectShippingAddressPage(),
        binding: AddressBinding(),
        middlewares: [AuthGuard()],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 250),
      ),
    ],
    // GetPage(
    //   name: AppPageNames.register,
    //   page: () => const RegisterPage(),
    //   binding: RegisterPageBinding(),
    // ),

    // Product List
    GetPage(
      name: ProductListPage.routeName,
      page: () => const ProductListPage(),
      binding: ProductListBinding(),
    ),
    // Wishlist
    GetPage(
      name: AppPageNames.wishlist,
      page: () => const WishlistPage(),
      middlewares: [AuthGuard()],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // Viewed Products
    GetPage(
      name: AppPageNames.viewedProducts,
      page: () => const ViewedProductPage(),
      binding: ViewedProductBinding(),
      middlewares: [AuthGuard()],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // Catalog Search
    GetPage(
      name: AppPageNames.catalogSearch,
      page: () => const SearchPage(),
      binding: SearchPageBinding(),
    ),
    // Product Detail
    GetPage(
      name: AppPageNames.productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductDetailPageBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // Product Information
    GetPage(
      name: '/product-information',
      page: () => const ProductInformationPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // FAQ List
    GetPage(
      name: AppPageNames.faqList,
      page: () => const FaqListPage(),
      binding: FaqListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // FAQ Detail
    GetPage(
      name: AppPageNames.faqDetail,
      page: () => const FaqDetailPage(),
      binding: FaqDetailBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // Customer Support
    GetPage(
      name: AppPageNames.customerSupport,
      page: () => const CustomerSupportPage(),
      binding: CustomerSupportBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // Page View
    GetPage(
      name: AppPageNames.pageView,
      page: () => const PageViewPage(),
      binding: PageViewBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
  ];
}
