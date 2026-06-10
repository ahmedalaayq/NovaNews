import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:nova_news/core/theme/light_theme.dart';

import '../router/on_generate_route.dart';

class NovaNews extends StatefulWidget {
  const NovaNews({super.key});

  @override
  State<NovaNews> createState() => _NovaNewsState();
}

class _NovaNewsState extends State<NovaNews> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        statusBarIconBrightness: Brightness.dark,

        statusBarBrightness: Brightness.light,

        systemNavigationBarColor: Colors.white,

        systemNavigationBarIconBrightness:
        Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      builder: (context,_){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NovaNews',
          onGenerateRoute: onGenerateRoute,
          initialRoute: AppRoutes.splashView,
          theme: lightTheme,
        );
      }
    );
  }
}