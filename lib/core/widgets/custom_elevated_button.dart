import 'package:flutter/material.dart';

import '../utils/app_sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.size,
    required this.buttonText,
    this.child,
  });
  final void Function()? onPressed;
  final Size? size;
  final String buttonText;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Size infiniteSize = MediaQuery.sizeOf(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(infiniteSize.width, AppSizes.h(48)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: onPressed,
      child: child ?? Text(buttonText),
    );
  }
}
