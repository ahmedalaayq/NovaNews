import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/theme/light_theme.dart';
import '../router/on_generate_route.dart';

class NovaNews extends StatelessWidget {
  const NovaNews({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NovaNews',
      onGenerateRoute: onGenerateRoute,
      initialRoute: AppRoutes.splashView,
      theme: lightTheme,
    );
  }
}
