import 'package:flutter/material.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

class CustomTileText extends StatelessWidget {
  const CustomTileText({super.key, required this.text, this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style ??
          Theme.of(context).textTheme.titleMedium?.copyWith(
            color: LightAppColors.whiteBgColor,
            fontSize: 16,
            fontWeight: .bold,
          ),
    );
  }
}
