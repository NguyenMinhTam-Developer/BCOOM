// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../domain/entities/my_gifts.dart';
// import '../controllers/my_gifts_controller.dart';
// import '../widgets/gift_item.dart';

// class MyGiftsPage extends GetView<MyGiftsController> {
//   const MyGiftsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quà của tôi'),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           _buildTabBar(),
//           Expanded(
//             child: _buildTabView(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Obx(() => Row(
//             spacing: 16.w,
//             children: [
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Đang hiệu lực',
//                   isSelected: controller.currentTabIndex.value == 0,
//                   onTap: () => controller.onTabChanged(0),
//                 ),
//               ),
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Đã sử dụng',
//                   isSelected: controller.currentTabIndex.value == 1,
//                   onTap: () => controller.onTabChanged(1),
//                 ),
//               ),
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Hết hạn',
//                   isSelected: controller.currentTabIndex.value == 2,
//                   onTap: () => controller.onTabChanged(2),
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
//           _buildGiftsList(controller.activeGifts),
//           _buildGiftsList(controller.usedGifts),
//           _buildGiftsList(controller.expiredGifts),
//         ],
//       ),
//     );
//   }

//   Widget _buildGiftsList(RxList<MyGiftsEntity> gifts) {
//     return RefreshIndicator(
//       onRefresh: controller.refreshData,
//       child: Obx(() {
//         if (controller.isLoading.value && gifts.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (gifts.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.card_giftcard,
//                   size: 64.w,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'Chưa có quà nào',
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

//         return ListView.builder(
//           padding: EdgeInsets.all(16.w),
//           itemCount: gifts.length,
//           itemBuilder: (context, index) {
//             final gift = gifts[index];
//             return GiftItem(gift: gift);
//           },
//         );
//       }),
//     );
//   }
// }
