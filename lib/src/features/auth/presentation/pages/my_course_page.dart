// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../domain/entities/my_course.dart';
// import '../controllers/my_course_controller.dart';
// import '../widgets/course_item.dart';

// class MyCoursePage extends GetView<MyCourseController> {
//   const MyCoursePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Khóa học của tôi'),
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
//                   title: 'Đang học',
//                   isSelected: controller.currentTabIndex.value == 0,
//                   onTap: () => controller.onTabChanged(0),
//                 ),
//               ),
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Hoàn thành',
//                   isSelected: controller.currentTabIndex.value == 1,
//                   onTap: () => controller.onTabChanged(1),
//                 ),
//               ),
//               Expanded(
//                 child: _buildTabButton(
//                   title: 'Đã lưu',
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
//           _buildCoursesList(controller.ongoingCourses),
//           _buildCoursesList(controller.completedCourses),
//           _buildCoursesList(controller.savedCourses),
//         ],
//       ),
//     );
//   }

//   Widget _buildCoursesList(RxList<MyCourseEntity> courses) {
//     return RefreshIndicator(
//       onRefresh: controller.refreshData,
//       child: Obx(() {
//         if (controller.isLoading.value && courses.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (courses.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.school,
//                   size: 64.w,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   'Chưa có khóa học nào',
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
//           itemCount: courses.length + (controller.hasMoreData.value ? 1 : 0),
//           separatorBuilder: (context, index) => SizedBox(height: 18.h),
//           itemBuilder: (context, index) {
//             if (index == courses.length) {
//               // Load more indicator
//               return _buildLoadMoreIndicator();
//             }

//             final course = courses[index];
//             return MyCourseItem(course: course);
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
//                   color: Color(0xFF639E10),
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
