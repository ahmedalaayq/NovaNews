import 'package:flutter/material.dart';
import 'package:nova_news/Features/auth/presentation/views/widgets/register_form.dart';
import 'package:nova_news/core/utils/assets.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final infinteSize = MediaQuery.sizeOf(context);
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
        padding: const EdgeInsets.all(16.0),
        child: RegisterForm(),
      ),
    );
  }
}
