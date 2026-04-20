import 'package:flutter/material.dart';
import 'package:nova_news/Features/splash/presentation/views/splash_view.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/router/no_route_found.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashView:
      return MaterialPageRoute(builder: (context) => SplashView());
    default:
      return MaterialPageRoute(builder: (context) => NoRouteFound());
  }
}
