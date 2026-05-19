import 'package:flutter/material.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: .fill,
      width: double.infinity,
      'assets/images/splash.png',
    );
  }
}
