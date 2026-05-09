import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/presentation/views/home_view.dart';
import 'package:nova_news/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:nova_news/Features/splash/presentation/views/splash_view.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/router/no_route_found.dart';
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashView:
      return MaterialPageRoute(builder: (context) => SplashView());
    case AppRoutes.onboardingView:
      return MaterialPageRoute(builder: (context) => OnboardingView());
    case AppRoutes.homeView:
      return MaterialPageRoute(builder: (context) => HomeView());
    default:
      return MaterialPageRoute(builder: (context) => NoRouteFound());
  }
}
