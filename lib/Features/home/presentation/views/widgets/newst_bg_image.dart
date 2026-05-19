import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/assets.dart';

class NewstBgImage extends StatelessWidget {
  const NewstBgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      width: 473,
      height: 242,
      fit: .cover,
      AppAssets.assetsImagesNewsBg,
    );
  }
}
