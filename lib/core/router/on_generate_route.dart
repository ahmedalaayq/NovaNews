import 'package:flutter/material.dart';
import 'package:nova_news/Features/auth/presentation/views/login_view.dart';
import 'package:nova_news/Features/auth/presentation/views/register_view.dart';
import 'package:nova_news/Features/home/presentation/views/home_view.dart';
import 'package:nova_news/Features/main/presentation/views/main_view.dart';
import 'package:nova_news/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:nova_news/Features/splash/controller/splash_controller.dart';
import 'package:nova_news/Features/splash/presentation/views/splash_view.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/router/no_route_found.dart';
import 'package:provider/provider.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashView:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => SplashController(),
          child: SplashView(),
        ),
      );
    case AppRoutes.onboardingView:
      return MaterialPageRoute(
        builder: (context) => OnboardingView(),
      );
    case AppRoutes.loginView:
      return MaterialPageRoute(builder: (context) => LoginView());
    case AppRoutes.registerView:
      return MaterialPageRoute(builder: (context) => RegisterView());
    case AppRoutes.homeView:
      return MaterialPageRoute(builder: (context) => HomeView());
    case AppRoutes.mainView:
      return MaterialPageRoute(builder: (context) => MainView());
    default:
      return MaterialPageRoute(builder: (context) => NoRouteFound());
  }
}
