import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_news/Features/profile/presentation/controller/profile_controller.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/assets.dart';
import 'package:nova_news/core/widgets/custom_svg_picture.dart';
import 'package:provider/provider.dart';

import '../../bottom_sheets/edit_user_personal_sheet.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .bold),
          ),
        ),
        SizedBox(height: AppSizes.h(20)),
        Center(
          child: Stack(
            alignment: .bottomRight,
            children: [
              Selector<ProfileController, XFile?>(
                builder: (BuildContext context, file, Widget? child) {
                  return CircleAvatar(
                    backgroundImage: file != null
                        ? FileImage(File(file.path))
                        : AssetImage(AppAssets.assetsImagesAhmed),
                    radius: AppSizes.r(43),
                    onBackgroundImageError: (context, error) => Container(
                      width: AppSizes.w(85),
                      height: AppSizes.h(85),
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  );
                },
                selector: (BuildContext p1, p2) {
                  return p2.selectedImage;
                },
              ),
              GestureDetector(
                onTap: () {
                  _pickImage(context);
                },
                child: Container(
                  padding: .all(AppSizes.r(8)),
                  decoration: BoxDecoration(shape: .circle, color: Colors.white),
                  width: AppSizes.w(34),
                  height: AppSizes.w(34),
                  child: Icon(Icons.camera_alt, size: AppSizes.r(20)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.h(8)),
        Selector<ProfileController, String?>(
          builder: (BuildContext context, username, Widget? child) {
            return Text(
              "$username".capitalizeEachWord(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .w500),
            );
          },
          selector: (BuildContext p1, p2) {
            return p2.username;
          },
        ),
        SizedBox(height: AppSizes.h(16)),
        Align(
          alignment: .centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'profile info'.capitalizeEachWord(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                _buildProfileItem(
                  context,
                  AppAssets.person,
                  'personal info'.capitalizeEachWord(),
                  () {
                    _showEditUserPersonalSheet(context);
                  },
                ),
                _buildProfileItem(
                  context,
                  AppAssets.language,
                  'language'.capitalizeEachWord(),
                  () {},
                ),
                _buildProfileItem(context, AppAssets.flag, 'country'.capitalizeEachWord(), () {}),
                _buildProfileItem(
                  context,
                  AppAssets.termsConditions,
                  'Terms & Conditions'.capitalizeEachWord(),
                  () {},
                ),
                _buildProfileItem(context, AppAssets.logout, 'logout'.capitalizeEachWord(), () {
                  context.read<ProfileController>().logout(context);
                }, isLogout: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    String path,
    String title,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: .zero,
          leading: CustomSvgPicture(path: path),
          title: Text(title),
          titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isLogout ? LightAppColors.primaryColor : Colors.black,
          ),
          trailing: isLogout
              ? CustomSvgPicture.withColor(
                  path: AppAssets.arrowForward,
                  color: LightAppColors.primaryColor,
                  height: AppSizes.r(24),
                  width: AppSizes.r(24),
                )
              : CustomSvgPicture(
                  path: AppAssets.arrowForward,
                  height: AppSizes.r(24),
                  width: AppSizes.r(24),
                ),
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          maintainInteractivity: true,
          visible: !isLogout,
          child: Divider(color: Color(0xFFD1DAD6)),
        ),
      ],
    );
  }

  void _pickImage(BuildContext mainContext) {
    showDialog(
      context: mainContext,
      builder: (context) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Image',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'Select where you want to get your image from',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageOption(
                      context,
                      icon: Icons.camera_alt_rounded,
                      title: "Camera",
                      onTap: () {
                        mainContext.read<ProfileController>().pickImage(.camera);
                        Navigator.pop(mainContext);
                      },
                    ),

                    _buildImageOption(
                      mainContext,
                      icon: Icons.photo_library_rounded,
                      title: "Gallery",
                      onTap: () {
                        mainContext.read<ProfileController>().pickImage(.gallery);
                        Navigator.pop(mainContext);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 30,
              child: Icon(icon, size: 28, color: Colors.black),
            ),

            const SizedBox(height: 10),

            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  void _showEditUserPersonalSheet(BuildContext mainContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: mainContext,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: mainContext.read<ProfileController>(),
          child: const EditUserPersonalSheet(),
        );
      },
    );
  }
}
