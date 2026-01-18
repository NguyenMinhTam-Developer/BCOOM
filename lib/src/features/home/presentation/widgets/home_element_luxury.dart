import 'dart:convert';

import '../../../../core/theme/app_colors.dart';
import 'section_background.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/usecases/get_home_product_usecase.dart';
import '../controllers/home_product_controller.dart';
import 'product_card.dart';

class HomeElementLuxury extends StatefulWidget {
  const HomeElementLuxury({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<HomeElementLuxury> createState() => _HomeElementLuxuryState();
}

class _HomeElementLuxuryState extends State<HomeElementLuxury> {
  late final HomeProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HomeProductController(getHomeProductUseCase: Get.find<GetHomeProductUseCase>()),
      tag: (widget.key as ValueKey<String>).value,
    );

    Map<String, dynamic> keywords = jsonDecode(widget.data['keywords']);

    _controller.getHomeProduct(
      keywords: keywords,
    );
  }

  @override
  void dispose() {
    Get.delete<HomeProductController>(tag: (widget.key as ValueKey<String>).value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SectionBackground(
              imageUrl: widget.data['image_url'],
              imageLocation: widget.data['image_location'],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(bottom: 180.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.h,
                children: [
                  Builder(builder: (context) {
                    final totalLength = widget.data['title']?.toString().split('<br>').length ?? 0;

                    final title = widget.data['title']?.toString().split('<br>').lastOrNull ?? '';
                    final subtitle = widget.data['title']?.toString().split('<br>').firstOrNull ?? '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Luxury',
                          style: GoogleFonts.arizonia(
                            color: Colors.white,
                            fontSize: 48.sp,
                          ),
                        ),
                        Text(
                          totalLength > 1 ? subtitle : '',
                          style: AppTextStyles.body12.copyWith(color: AppColors.secondaryPink),
                        ),
                        Text(
                          title,
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.ink1,
                            fontFamily: GoogleFonts.ibmPlexSerif().fontFamily,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 150.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () => Row(
                spacing: 16.w,
                children: List.generate(_controller.homeProduct.value?['rows']?.length ?? 0, (index) {
                  var width = (Get.width - (16.w * (2 + 1))) / 1.6;

                  return SizedBox(
                    width: width,
                    child: ProductCard(product: _controller.homeProduct.value?['rows'][index]),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
