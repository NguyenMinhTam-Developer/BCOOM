// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import 'package:pharmacom/src/shared/widgets/image_placeholder.dart';

// import '../../../../core/theme/app_color.dart';
// import '../../domain/entities/my_course.dart';

// class MyCourseItem extends StatelessWidget {
//   const MyCourseItem({super.key, required this.course});

//   final MyCourseEntity course;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 16.w,
//       children: [
//         Expanded(
//           child: Column(
//             spacing: 12.h,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 course.courseName,
//                 maxLines: 2,
//                 style: context.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14.sp,
//                   color: Color(0xFF894943),
//                 ),
//               ),
//               Row(
//                 spacing: 16.w,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       spacing: 6.w,
//                       children: [
//                         Icon(
//                           Symbols.book_2_rounded,
//                           fill: 1,
//                           color: AppColors.primaryGreen,
//                           size: 18,
//                         ),
//                         Text(
//                           '${course.lessonCount} Bài học',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                           style: context.textTheme.bodyMedium?.copyWith(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Container(
//                   //   width: 1.w,
//                   //   height: 18.h,
//                   //   color: Color(0xFFD9D9D9),
//                   // ),
//                   // Expanded(
//                   //   child: Row(
//                   //     spacing: 6.w,
//                   //     children: [
//                   //       Icon(
//                   //         Symbols.timer_rounded,
//                   //         fill: 1,
//                   //         color: AppColors.primaryGreen,
//                   //         size: 18,
//                   //       ),
//                   //       Expanded(
//                   //         child: Text(
//                   //           '24:56',
//                   //           maxLines: 1,
//                   //           overflow: TextOverflow.ellipsis,
//                   //           textAlign: TextAlign.center,
//                   //           style: context.textTheme.bodyMedium?.copyWith(
//                   //             fontWeight: FontWeight.w400,
//                   //             fontSize: 12.sp,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 80.h,
//           width: 140.w,
//           child: CachedNetworkImage(
//             imageUrl: course.courseImage,
//             placeholder: (context, url) => ImagePlaceholder(fit: BoxFit.contain),
//             errorWidget: (context, url, error) => ImagePlaceholder(fit: BoxFit.contain),
//           ),
//         )
//       ],
//     );
//   }
// }
