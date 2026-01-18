// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pharmacom/src/core/utils/currency_utils.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

// import '../../../../core/theme/app_color.dart';
// import '../../domain/entities/my_point_history.dart';

// class PointHistoryItem extends StatelessWidget {
//   final MyPointHistoryEntity history;
//   final PointHistoryType type;

//   const PointHistoryItem({
//     super.key,
//     required this.history,
//     required this.type,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color mainColor = type == PointHistoryType.accumulate ? AppColors.primaryAlertGreen : AppColors.primaryAlertRed;
//     PhosphorIconData icon = type == PointHistoryType.accumulate ? PhosphorIcons.plusCircle(PhosphorIconsStyle.fill) : PhosphorIcons.minusCircle(PhosphorIconsStyle.fill);

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 16.w,
//       children: [
//         Container(
//           width: 32.w,
//           height: 32.w,
//           decoration: BoxDecoration(
//             color: mainColor.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: PhosphorIcon(
//               icon,
//               size: 24.w,
//               color: mainColor,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             spacing: 4.h,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 history.title,
//                 style: context.textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.sp,
//                   color: AppColors.primaryGreen,
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 16.w,
//                 children: [
//                   Expanded(
//                     child: RichText(
//                       text: TextSpan(
//                         text: "${history.title} ",
//                         style: context.textTheme.bodyLarge?.copyWith(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: history.campaign.name,
//                             style: context.textTheme.bodyLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                               color: Colors.black,
//                             ),
//                           ),
//                           TextSpan(
//                             // text: " thành công, Số lượng ${history.campaign.quantity}",
//                             text: " thành công.",
//                             style: context.textTheme.bodyLarge?.copyWith(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14.sp,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   RichText(
//                     text: TextSpan(
//                       text: " ${type == PointHistoryType.accumulate ? '+' : '-'}${CurrencyUtils.formatVNDWithoutSymbol(history.campaign.points.abs())}",
//                       style: context.textTheme.bodyLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.sp,
//                         color: mainColor,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: " điểm",
//                           style: context.textTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w100,
//                             fontSize: 14.sp,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 DateFormat("dd/MM/yyyy . HH:mm").format(history.createdAt),
//                 style: context.textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12.sp,
//                   color: Colors.black.withValues(alpha: 0.56),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
