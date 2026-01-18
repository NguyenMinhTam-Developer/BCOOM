// import 'package:bcoom/src/core/routers/app_page_names.dart';
// import 'package:bcoom/src/core/services/session/session_service.dart';
// import 'package:bcoom/src/core/utils/currency_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import '../../domain/entities/my_point_history.dart';
// import '../controllers/my_point_history_controller.dart';
// import '../widgets/point_history_item.dart';

// class MyPointHistoryPage extends GetView<MyPointHistoryController> {
//   const MyPointHistoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('LỊCH SỬ ĐIỂM CỦA TÔI'),
//         elevation: 0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildCurrentPoint(),
//           _buildTabBar(),
//           Expanded(
//             child: _buildTabView(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCurrentPoint() {
//     num? points = SessionService.instance.currentUser.value?.points ?? 0;

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       decoration: BoxDecoration(
//         color: Color(0xFF639E10).withValues(alpha: 0.1),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12.r),
//           topRight: Radius.circular(12.r),
//           bottomLeft: Radius.circular(24.r),
//           bottomRight: Radius.circular(24.r),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildInfoItem(
//                   icon: Symbols.database_rounded,
//                   title: 'Điểm thưởng hiện tại',
//                   value: CurrencyUtils.formatVNDWithoutSymbol(points),
//                   actionText: "Đổi quà",
//                   onActionTap: () {
//                     Get.toNamed(AppPageNames.gifts);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem({
//     required IconData icon,
//     required String title,
//     required String value,
//     bool fillIcon = false,
//     String? badgeText,
//     String? actionText,
//     VoidCallback? onActionTap,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 16.w,
//       children: [
//         Icon(
//           icon,
//           size: 32.h,
//           fill: fillIcon ? 1 : 0,
//           color: Color(0xFF639E10),
//         ),
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Row(
//                 spacing: 16.w,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       spacing: 8.w,
//                       children: [
//                         Flexible(
//                           child: Text(
//                             value,
//                             style: TextStyle(
//                               fontSize: 32.sp,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFF639E10),
//                             ),
//                           ),
//                         ),
//                         if (badgeText != null)
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF34C759),
//                               borderRadius: BorderRadius.circular(99.r),
//                             ),
//                             child: Text(
//                               badgeText,
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   if (actionText != null)
//                     GestureDetector(
//                       onTap: onActionTap,
//                       child: Row(
//                         spacing: 6.w,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             actionText,
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           Icon(
//                             Symbols.arrow_circle_right_rounded,
//                             size: 16.h,
//                             fill: 1,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       // decoration: BoxDecoration(
//       //   color: Colors.grey[100],
//       //   borderRadius: BorderRadius.circular(12.r),
//       // ),
//       child: Obx(() => Row(
//             spacing: 16.w,
//             children: [
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Tích lũy điểm',
//                   isSelected: controller.currentTabIndex.value == 0,
//                   onTap: () => controller.onTabChanged(0),
//                 ),
//               ),
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Sử dụng điểm',
//                   isSelected: controller.currentTabIndex.value == 1,
//                   onTap: () => controller.onTabChanged(1),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _buildTabButton({
//     required String title,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 30.h,
//         // padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//         // margin: EdgeInsets.all(4.w),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xFF223A00) : Color(0xFFBDC4B3),
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         child: Center(
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: Get.textTheme.bodyLarge?.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 12.sp,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTabView() {
//     return Obx(
//       () => IndexedStack(
//         index: controller.currentTabIndex.value,
//         children: [
//           _buildHistoryList(controller.accumulateHistory, controller.accumulateTotal),
//           _buildHistoryList(controller.redeemHistory, controller.redeemTotal),
//         ],
//       ),
//     );
//   }

//   Widget _buildHistoryList(RxList<MyPointHistoryEntity> history, RxInt total) {
//     return RefreshIndicator(
//       onRefresh: controller.refreshData,
//       child: Obx(() {
//         if (controller.isLoading.value && history.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (history.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.history,
//                   size: 64.w,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'Chưa có lịch sử điểm',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.separated(
//           padding: EdgeInsets.all(16.w),
//           itemCount: history.length + (controller.hasMoreData.value ? 1 : 0),
//           separatorBuilder: (context, index) => SizedBox(height: 18.h),
//           itemBuilder: (context, index) {
//             if (index == history.length) {
//               // Load more indicator
//               return _buildLoadMoreIndicator();
//             }

//             final item = history[index];

//             return PointHistoryItem(
//               history: item,
//               type: controller.currentType.value,
//             );
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLoadMoreIndicator() {
//     return Obx(() {
//       if (controller.isLoadingMore.value) {
//         return Container(
//           padding: EdgeInsets.all(16.w),
//           child: const Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       }

//       if (controller.hasMoreData.value) {
//         return Container(
//           padding: EdgeInsets.all(16.w),
//           child: Center(
//             child: TextButton(
//               onPressed: controller.loadMoreData,
//               child: Text(
//                 'Tải thêm',
//                 style: TextStyle(
//                   color: AppColors.primaryGreen,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }

//       return Container(
//         padding: EdgeInsets.all(16.w),
//         child: Center(
//           child: Text(
//             'Đã tải hết dữ liệu',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14.sp,
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
