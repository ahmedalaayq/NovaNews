import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_sizes.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width, height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      errorWidget: (context, url, error) {
        return Container(
          width: width ?? AppSizes.w(300),
          height: height ?? AppSizes.h(240),
          decoration: BoxDecoration(color: Colors.grey),
          child: Icon(Icons.broken_image),
        );
      },
      fit: fit ?? .fill,
      fadeInCurve: Curves.easeInOut,
      height: height ?? AppSizes.h(70),
      width: width ?? AppSizes.h(122),
      imageUrl: imageUrl,
    );
  }
}
