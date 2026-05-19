import 'package:flutter/material.dart';
import 'package:nova_news/Features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';

import 'login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthController>(
      create: (context) => AuthController()..init(),
      child: Scaffold(body: LoginViewBody()),
    );
  }
}
