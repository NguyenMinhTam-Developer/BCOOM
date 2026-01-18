// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pharmacom/src/core/utils/currency_utils.dart';
// import 'package:pharmacom/src/features/webview/webview_page.dart';

// import '../../../../core/theme/app_color.dart';
// import '../../domain/entities/my_gifts.dart';

// class GiftItem extends StatelessWidget {
//   final MyGiftsEntity gift;

//   const GiftItem({
//     super.key,
//     required this.gift,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (gift.voucherLink.isNotEmpty) {
//           WebviewPage.openWebview(url: gift.voucherLink, title: gift.voucherName);
//         } else {
//           Get.snackbar('Thông báo', 'Quà tặng không có liên kết', snackPosition: SnackPosition.TOP);
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12.h),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Color(0xFF455A64).withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(color: Colors.grey[200]!),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           spacing: 16.w,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildImage(),
//             Expanded(
//               child: _buildContent(),
//             ),
//             _buildStatusBadge(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImage() {
//     return Container(
//       width: 48.w,
//       height: 48.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r),
//         color: Colors.grey[200],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8.r),
//         child: gift.voucherImage.isNotEmpty
//             ? Image.network(
//                 gift.voucherImage,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     color: Colors.grey[200],
//                     child: Icon(
//                       Icons.card_giftcard,
//                       size: 32.w,
//                       color: Colors.grey[400],
//                     ),
//                   );
//                 },
//               )
//             : Container(
//                 color: Colors.grey[200],
//                 child: Icon(
//                   Icons.card_giftcard,
//                   size: 32.w,
//                   color: Colors.grey[400],
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return Column(
//       spacing: 6.h,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           gift.voucherName,
//           style: Get.textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.w700,
//             fontSize: 14.sp,
//           ),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: CurrencyUtils.formatCurrentlyWithLocalText(gift.voucherPrice),
//                 style: Get.textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 24.sp,
//                   color: AppColors.primaryRed,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'đ',
//                     style: Get.textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16.sp,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusBadge() {
//     Color badgeColor;
//     Color textColor;
//     String statusText;

//     switch (gift.status) {
//       case GiftStatus.active:
//         badgeColor = AppColors.primaryGreen;
//         textColor = Colors.white;
//         statusText = gift.status.displayValue;
//         break;
//       case GiftStatus.used:
//         badgeColor = Colors.blue;
//         textColor = Colors.white;
//         statusText = gift.status.displayValue;
//         break;
//       case GiftStatus.expired:
//         badgeColor = Colors.red;
//         textColor = Colors.white;
//         statusText = gift.status.displayValue;
//         break;
//     }

//     return Column(
//       spacing: 8.h,
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         if (gift.status == GiftStatus.active)
//           RichText(
//             text: TextSpan(
//               text: "Đến: ",
//               style: Get.textTheme.bodyLarge?.copyWith(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFA2845E),
//               ),
//               children: [
//                 TextSpan(
//                   text: DateFormat('dd/MM/yyyy').format(gift.expiredAt),
//                   style: Get.textTheme.bodyLarge?.copyWith(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFA2845E),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         // Text(
//         //   'Đến ${DateFormat('dd/MM/yyyy').format(gift.expiredAt)}',
//         //   style: Get.textTheme.bodyLarge?.copyWith(
//         //     fontSize: 12.sp,
//         //     fontWeight: FontWeight.w400,
//         //     color: Colors.grey[600],
//         //   ),
//         // ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//           decoration: BoxDecoration(
//             color: badgeColor,
//             borderRadius: BorderRadius.circular(99.r),
//           ),
//           child: Text(
//             statusText,
//             style: TextStyle(
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w600,
//               color: textColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
