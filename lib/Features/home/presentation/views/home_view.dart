import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..init(),
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primaryContainer,
          body: HomeViewBody(),
        );
      },
    );
  }
}
