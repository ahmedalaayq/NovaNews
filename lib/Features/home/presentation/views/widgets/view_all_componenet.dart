import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/custom_tile_text.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

class ViewAllComponenet extends StatelessWidget {
  const ViewAllComponenet({
    super.key,
    required this.title,
    this.color,
    required this.onTap,
  });
  final String title;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        CustomTileText(
          text: title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: color ?? LightAppColors.whiteBgColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: CustomTileText(
            text: 'View all',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color ?? LightAppColors.whiteBgColor,
              fontSize: 16,
              fontWeight: .w400,
              decoration: .underline,
              decorationColor: color ?? LightAppColors.whiteBgColor,
            ),
          ),
        ),
      ],
    );
  }
}
