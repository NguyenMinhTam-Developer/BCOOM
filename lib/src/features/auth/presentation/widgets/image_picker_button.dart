import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../infrastructure/device/image_picker_service.dart';
import '../../../../infrastructure/device/image_source_dialog.dart';

class ImagePickerButton extends StatelessWidget {
  final Function(File) onImagePicked;
  final File? currentImage;
  final String? initialNetworkImage;

  const ImagePickerButton({
    super.key,
    required this.onImagePicked,
    this.currentImage,
    this.initialNetworkImage,
  });

  Future<void> _handleImagePick(BuildContext context) async {
    final imagePickerService = ImagePickerService();

    await ImageSourceDialog.show(
      context: context,
      onCameraTap: () async {
        final image = await imagePickerService.pickImageFromCamera();
        if (image != null) {
          onImagePicked(image);
        }
      },
      onGalleryTap: () async {
        final image = await imagePickerService.pickImageFromGallery();
        if (image != null) {
          onImagePicked(image);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        color: Color(0xFFD9D9D9),
        shape: CircleBorder(),
        child: InkWell(
          onTap: () => _handleImagePick(context),
          child: SizedBox(
            width: 96.w,
            height: 96.w,
            child: Builder(builder: (context) {
              if (currentImage != null) {
                return Image.file(
                  currentImage!,
                  fit: BoxFit.cover,
                );
              } else if (initialNetworkImage != null) {
                return CachedNetworkImage(
                  imageUrl: initialNetworkImage!,
                  fit: BoxFit.cover,
                );
              }

              return Center(
                child: Icon(
                  Symbols.add_a_photo,
                  size: 32.w,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
