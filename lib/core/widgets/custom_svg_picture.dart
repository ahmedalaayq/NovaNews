import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({super.key, required this.path, this.width, this.height}) : color = null;

  const CustomSvgPicture.withColor({
    super.key,
    required this.path,
    this.width,
    this.height,
    required this.color,
  });

  final String path;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.fill,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
