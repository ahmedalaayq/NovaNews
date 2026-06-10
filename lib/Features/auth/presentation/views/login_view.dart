import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_news/Features/auth/controller/auth_controller.dart';
import 'package:nova_news/Features/auth/controller/auth_controller_cubit.dart';
import 'package:provider/provider.dart';

import 'login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthControllerCubit>(
      create: (context) => AuthControllerCubit(),
      child: Scaffold(body: LoginViewBody()),
    );
  }
}
