import 'package:flutter/material.dart';
import 'package:nova_news/Features/splash/controller/splash_controller.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashController controller;

  @override
  void initState() {
    super.initState();
    controller = SplashController();
    WidgetsBinding.instance.addPostFrameCallback((state) {
      controller.executeNavigation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
