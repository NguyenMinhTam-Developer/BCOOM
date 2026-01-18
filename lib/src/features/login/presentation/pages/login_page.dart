// import '../../../../shared/colors/app_colors.dart';
// import '../../../../shared/components/buttons.dart';
// import '../../../../shared/components/custom_form_builder_text_field.dart';
// import '../../../../shared/typography/app_text_styles.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:material_symbols_icons/material_symbols_icons.dart';

// import '../controllers/login_controller.dart';

// class LoginPage extends GetView<LoginController> {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           surfaceTintColor: Colors.transparent,
//           backgroundColor: AppColors.bg200,
//           actions: [
//             Card(
//               elevation: 0,
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusGeometry.only(
//                 bottomLeft: Radius.circular(8.r),
//                 topRight: Radius.circular(8.r),
//               )),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                 child: Row(
//                   spacing: 5.w,
//                   children: [
//                     Icon(Symbols.language, size: 14.sp, color: AppColors.text500),
//                     Text(
//                       "Tiếng Anh",
//                       style: AppTextStyles.label12.copyWith(
//                         color: AppColors.text300,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//           bottom: PreferredSize(preferredSize: Size.fromHeight(1.h), child: Container(color: AppColors.bg400)),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//           child: Column(
//             spacing: 20.h,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 "Đăng nhập",
//                 style: AppTextStyles.heading2.copyWith(color: AppColors.text500),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 spacing: 16.h,
//                 children: [
//                   TabBar(
//                     controller: controller.tabController,
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     indicatorColor: AppColors.text500,
//                     dividerColor: AppColors.bg500,
//                     dividerHeight: 1.h,
//                     labelPadding: EdgeInsets.zero,
//                     labelStyle: AppTextStyles.body14.copyWith(color: AppColors.text500),
//                     unselectedLabelStyle: AppTextStyles.body14.copyWith(color: AppColors.text300),
//                     tabs: [
//                       Tab(text: "Số điện thoại"),
//                       Tab(text: "Email"),
//                       Tab(text: "ID BCOOM"),
//                     ],
//                   ),
//                   Obx(() => _buildLoginForm()),
//                 ],
//               ),
//               Obx(
//                 () => AppButton.primary(
//                   onPressed: controller.isLoading ? null : controller.login,
//                   label: controller.isLoading ? "Đang đăng nhập..." : "Đăng nhập",
//                 ),
//               ),
//               Text(
//                 "Quên mật khẩu?",
//                 style: AppTextStyles.label14.copyWith(color: AppColors.text400),
//               ),
//               Align(
//                 child: Card(
//                   color: Color(0xFFFFF3ED),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(16.r),
//                     onTap: controller.loginWithBiometric,
//                     child: Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Icon(
//                         Symbols.familiar_face_and_zone_rounded,
//                         size: 34.h,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//             child: RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "Bạn chưa có tài khoản BCOOM? ",
//                     style: AppTextStyles.body12.copyWith(color: AppColors.text400),
//                   ),
//                   TextSpan(
//                     text: "Đăng ký ngay",
//                     style: AppTextStyles.heading6.copyWith(color: AppColors.primaryColor),
//                     recognizer: TapGestureRecognizer()..onTap = controller.navigateToRegister,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget _buildLoginForm() {
//     switch (controller.selectedLoginMethod.value) {
//       case LoginMethod.phone:
//         return _buildPhoneLoginForm();
//       case LoginMethod.email:
//         return _buildEmailLoginForm();
//       case LoginMethod.idBcoom:
//         return _buildIdBcoomLoginForm();
//     }
//   }

//   Widget _buildPhoneLoginForm() {
//     return Column(
//       spacing: 16.h,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Phone number input
//         CustomFormBuilderTextField(
//           name: 'phone_number',
//           labelText: 'Số điện thoại',
//           hintText: 'Nhập số điện thoại',
//           keyboardType: TextInputType.phone,
//           onChanged: (value) {
//             controller.phoneNumber.value = value ?? '';
//           },
//           validator: FormBuilderValidators.compose([
//             FormBuilderValidators.required(errorText: 'Vui lòng nhập số điện thoại'),
//             FormBuilderValidators.numeric(errorText: 'Số điện thoại không hợp lệ'),
//           ]),
//         ),
//         // Password field
//         Obx(
//           () => CustomFormBuilderTextField(
//             name: 'password',
//             labelText: 'Mật khẩu',
//             hintText: 'Nhập mật khẩu của bạn',
//             obscureText: !controller.isPasswordVisible.value,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               controller.password.value = value ?? '';
//             },
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: 'Vui lòng nhập mật khẩu'),
//             ]),
//             inputDecoration: InputDecoration(
//               suffixIcon: IconButton(
//                 onPressed: controller.togglePasswordVisibility,
//                 icon: Icon(controller.isPasswordVisible.value ? Symbols.visibility : Symbols.visibility_off),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmailLoginForm() {
//     return Column(
//       spacing: 16.h,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Email input
//         CustomFormBuilderTextField(
//           name: 'email',
//           labelText: 'Email',
//           hintText: 'Nhập địa chỉ email',
//           keyboardType: TextInputType.emailAddress,
//           onChanged: (value) {
//             controller.email.value = value ?? '';
//           },
//           validator: FormBuilderValidators.compose([
//             FormBuilderValidators.required(errorText: 'Vui lòng nhập email'),
//             FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
//           ]),
//         ),
//         // Password field
//         Obx(
//           () => CustomFormBuilderTextField(
//             name: 'password',
//             labelText: 'Mật khẩu',
//             hintText: 'Nhập mật khẩu của bạn',
//             obscureText: !controller.isPasswordVisible.value,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               controller.password.value = value ?? '';
//             },
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: 'Vui lòng nhập mật khẩu'),
//             ]),
//             inputDecoration: InputDecoration(
//               suffixIcon: IconButton(
//                 onPressed: controller.togglePasswordVisibility,
//                 icon: Icon(controller.isPasswordVisible.value ? Symbols.visibility : Symbols.visibility_off),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildIdBcoomLoginForm() {
//     return Column(
//       spacing: 16.h,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // ID Bcoom input
//         CustomFormBuilderTextField(
//           name: 'id_bcoom',
//           labelText: 'ID BCOOM',
//           hintText: 'Nhập ID BCOOM của bạn',
//           keyboardType: TextInputType.text,
//           onChanged: (value) {
//             controller.idBcoom.value = value ?? '';
//           },
//           validator: FormBuilderValidators.compose([
//             FormBuilderValidators.required(errorText: 'Vui lòng nhập ID BCOOM'),
//           ]),
//         ),
//         // Password field
//         Obx(
//           () => CustomFormBuilderTextField(
//             name: 'password',
//             labelText: 'Mật khẩu',
//             hintText: 'Nhập mật khẩu của bạn',
//             obscureText: !controller.isPasswordVisible.value,
//             keyboardType: TextInputType.visiblePassword,
//             onChanged: (value) {
//               controller.password.value = value ?? '';
//             },
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(errorText: 'Vui lòng nhập mật khẩu'),
//             ]),
//             inputDecoration: InputDecoration(
//               suffixIcon: IconButton(
//                 onPressed: controller.togglePasswordVisibility,
//                 icon: Icon(controller.isPasswordVisible.value ? Symbols.visibility : Symbols.visibility_off),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
