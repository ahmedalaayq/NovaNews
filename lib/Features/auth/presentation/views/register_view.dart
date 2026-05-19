import 'package:flutter/material.dart';
import 'package:nova_news/Features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';

import 'register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController()..init(),
      child: Scaffold(body: RegisterViewBody()),
    );
  }
}
