import 'package:flutter/material.dart';
import 'package:nova_news/Features/profile/presentation/controller/profile_controller.dart';
import 'package:nova_news/Features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> ProfileController()..loadUserData(),
        child: SafeArea(child: ProfileViewBody()));
  }
}
