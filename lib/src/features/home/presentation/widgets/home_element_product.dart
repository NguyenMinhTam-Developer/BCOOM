import 'dart:convert';

import '../../domain/usecases/get_home_product_usecase.dart';
import '../controllers/home_product_controller.dart';
import 'section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'product_card.dart';
import 'section_background.dart';

class HomeElementProduct extends StatefulWidget {
  const HomeElementProduct({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<HomeElementProduct> createState() => _HomeElementProductState();
}

class _HomeElementProductState extends State<HomeElementProduct> {
  late final HomeProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HomeProductController(getHomeProductUseCase: Get.find<GetHomeProductUseCase>()),
      tag: (widget.key as ValueKey<String>).value,
    );

    _controller.getHomeProduct(
      keywords: widget.data['keywords'].toString(),
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
      clipBehavior: Clip.none,
      children: [
        SectionBackground(
          imageUrl: widget.data['image_url'],
          imageLocation: widget.data['image_location'],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: [
              SectionTitle(
                rawTitle: widget.data['title']?.toString() ?? '',
                content: widget.data['content']?.toString() ?? '',
              ),
              SingleChildScrollView(
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
            ],
          ),
        ),
      ],
    );
  }
}
