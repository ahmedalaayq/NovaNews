import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imageUrl, this.width, this.height, this.fit});
  final String imageUrl;
  final double?width,height;
  final BoxFit ? fit;

  @override
  Widget build(BuildContext context) {
    const placeholderNetworkImage =
        'https://aideplus.com/wp-content/uploads/2017/09/image_large.png';
    return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return Image.network(placeholderNetworkImage);
      },
      fit: fit ?? .fill,
      fadeInCurve: Curves.easeInOut,
      height: height ?? 70,
      width: width ?? 122,
      imageUrl: imageUrl,
    );
  }
}
