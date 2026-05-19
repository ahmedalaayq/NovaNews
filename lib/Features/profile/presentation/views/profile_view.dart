import 'package:flutter/material.dart';
import 'package:nova_news/Features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ProfileViewBody());
  }
}
