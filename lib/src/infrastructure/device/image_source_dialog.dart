import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSourceDialog extends StatelessWidget {
  final Function() onCameraTap;
  final Function() onGalleryTap;

  const ImageSourceDialog({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  static Future<void> show({
    required BuildContext context,
    required Function() onCameraTap,
    required Function() onGalleryTap,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ImageSourceDialog(
        onCameraTap: onCameraTap,
        onGalleryTap: onGalleryTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
            leading: Icon(Icons.camera_alt),
            title: Text('Chụp ảnh'),
            onTap: () {
              Navigator.pop(context);
              onCameraTap();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
            leading: Icon(Icons.photo),
            title: Text('Chọn từ thư viện'),
            onTap: () {
              Navigator.pop(context);
              onGalleryTap();
            },
          ),
        ],
      ),
    );
  }
}
