import 'package:flutter/material.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/router/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NovaNews',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      onGenerateRoute: onGenerateRoute,
      initialRoute: AppRoutes.splashView,
    );
  }
}
