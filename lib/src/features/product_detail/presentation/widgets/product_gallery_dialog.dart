import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';

/// Full screen gallery dialog for viewing product images
class ProductGalleryDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ProductGalleryDialog({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  /// Show the gallery dialog
  static void show({
    required List<String> images,
    int initialIndex = 0,
  }) {
    Get.dialog(
      ProductGalleryDialog(
        images: images,
        initialIndex: initialIndex,
      ),
      barrierColor: Colors.black,
      useSafeArea: false,
    );
  }

  @override
  State<ProductGalleryDialog> createState() => _ProductGalleryDialogState();
}

class _ProductGalleryDialogState extends State<ProductGalleryDialog> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _downloadImage() {
    Get.snackbar(
      'Tải ảnh',
      'Đang tải ảnh về thiết bị...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: AppColors.text500,
      margin: const EdgeInsets.all(16),
    );
  }

  void _close() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        // title: Text('Ảnh sản phẩm', style: AppTextStyles.heading6.copyWith(color: Colors.white)),
        leading: IconButton(
          onPressed: _close,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
          ),
          icon: BackButton(
            color: Colors.black,
          ).icon,
        ),
      ),
      body: Stack(
        children: [
          // Image PageView
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final imageUrl = widget.images[index];
                
                return Container(
                  margin: EdgeInsets.all(16.w),
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 3.0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to placeholder on error
                            return Assets.images.products.productDetailImage.image(
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // // Back button (top left)
          // Positioned(
          //   top: MediaQuery.of(context).padding.top + 16.h,
          //   left: 16.w,
          //   child: GestureDetector(
          //     onTap: _close,
          //     child: Container(
          //       width: 44.w,
          //       height: 44.w,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withValues(alpha: 0.1),
          //             blurRadius: 8,
          //             offset: const Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Icon(
          //         Icons.chevron_left_rounded,
          //         size: 28.w,
          //         color: AppColors.text500,
          //       ),
          //     ),
          //   ),
          // ),

          // Bottom controls
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 24.h,
            child: Row(
              children: [
                // Download button (bottom left)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: GestureDetector(
                    onTap: _downloadImage,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Symbols.download_rounded,
                            size: 24.w,
                            color: AppColors.secondary500,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Tải ảnh',
                            style: AppTextStyles.cap10.copyWith(
                              color: AppColors.text500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Page indicator (bottom center)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${_currentIndex + 1}/${widget.images.length}',
                    style: AppTextStyles.label14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),

                const Spacer(),

                // Spacer to balance the layout
                SizedBox(width: 80.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
