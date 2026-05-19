import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/assets.dart';

class NewstAppbar extends StatelessWidget {
  const NewstAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: .cover,
      height: 70,
      width: 375,
      AppAssets.assetsImagesTopNewstAppbar,
    );
  }
}
