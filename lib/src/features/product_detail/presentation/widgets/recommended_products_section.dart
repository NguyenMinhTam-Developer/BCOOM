import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../home/presentation/widgets/home_product_widget.dart';
import '../controllers/product_detail_controller.dart';

/// Recommended products section with two-column grid layout
class RecommendedProductsSection extends GetView<ProductDetailController> {
  const RecommendedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          // Section title
          Text(
            'Có thể bạn thích',
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.text500,
            ),
          ),

          // Products grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 164.w / 228.h,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
            ),
            itemCount: controller.recommendedProducts.length,
            itemBuilder: (context, index) => HomeProductWidget(
              onTap: () => Get.toNamed(
                AppPageNames.productDetail.replaceAll(':id', 'product-$index'),
              ),
            ),
          ),
        ],
      );
    });
  }
}
