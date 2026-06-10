import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/assets.dart';

class NewstBgImage extends StatelessWidget {
  const NewstBgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      width: AppSizes.w(473),
      height: AppSizes.h(242),
      fit: .cover,
      AppAssets.assetsImagesNewsBg,
    );
  }
}
