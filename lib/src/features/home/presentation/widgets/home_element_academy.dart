import 'section_title.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'section_background.dart';

class HomeElementAcademy extends StatelessWidget {
  const HomeElementAcademy({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SectionBackground(
          imageUrl: data['image_url'],
          imageLocation: data['image_location'],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: [
              SectionTitle(
                rawTitle: data['title']?.toString() ?? '',
                content: data['content']?.toString() ?? '',
              ),
              AspectRatio(
                aspectRatio: (796 + 16.w * 2) / (225 + 16.w * 2),
                child: PageView.builder(
                  itemCount: (data['items'] as List<dynamic>).length,
                  itemBuilder: (context, index) {
                    var item = data['items'][index];
                    var itemImageUrl = item['image_url'];
                    var itemImageLocation = item['image_location'];

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: SectionBackground(
                        imageUrl: itemImageUrl,
                        imageLocation: itemImageLocation,
                        usePositioned: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
