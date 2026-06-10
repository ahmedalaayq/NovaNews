import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/assets.dart';

class NewstAppbar extends StatelessWidget {
  const NewstAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: .cover,
      height: AppSizes.h(70),
      width: AppSizes.w(375),
      AppAssets.assetsImagesTopNewstAppbar,
    );
  }
}
