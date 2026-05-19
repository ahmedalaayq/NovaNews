import 'package:flutter/material.dart';
import 'package:nova_news/Features/splash/controller/splash_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashController>().executeNavigation(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
