import 'package:flutter/material.dart';
import 'package:nova_news/Features/auth/presentation/views/widgets/login_form.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/assets.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: .fill,
          image: AssetImage(AppAssets.assetsImagesBackground),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.all(AppSizes.w(16)),
        child: LoginForm(),
      ),
    );
  }
}
