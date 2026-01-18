import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class SectionBackground extends StatelessWidget {
  const SectionBackground({super.key, this.imageUrl, this.imageLocation, this.usePositioned = true, this.fit});

  final String? imageUrl;
  final String? imageLocation;
  final bool usePositioned;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    Widget? adaptedWidget;

    if (imageUrl == null || imageLocation == null) {
      adaptedWidget ??= const SizedBox.shrink();
    } else if (imageLocation?.contains('.svg') ?? false) {
      adaptedWidget ??= CachedNetworkSVGImage(
        '$imageUrl$imageLocation',
        fit: fit ?? BoxFit.cover,
      );
    } else if (imageLocation!.contains('.png') || imageLocation!.contains('.jpg') || imageLocation!.contains('.jpeg')) {
      adaptedWidget ??= CachedNetworkImage(
        imageUrl: '$imageUrl$imageLocation',
        fit: fit ?? BoxFit.cover,
      );
    } else {
      adaptedWidget ??= const SizedBox.shrink();
    }

    if (usePositioned) {
      return Positioned.fill(
        child: adaptedWidget,
      );
    } else {
      return adaptedWidget;
    }
  }
}
