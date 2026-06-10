import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';
import 'package:nova_news/core/datasource/local/storage_key.dart';
import 'package:nova_news/core/mixins/safe_notify_mixin.dart';
import 'package:nova_news/core/router/app_routes.dart';
import 'package:path_provider/path_provider.dart' as p;
import "package:path/path.dart" as path;


class ProfileController with ChangeNotifier, SafeNotifyMixin {
  XFile? selectedImage;
  String? username;
  TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  // ── Image ─────────────────────────────────────────────────────────────────
  void pickImage(ImageSource source) async {
    try {
      final XFile? picked = await ImagePicker().pickImage(source: source);
      if (picked == null) return;
      selectedImage = picked;
      await saveImage();
      safeNotify();
    } catch (e) {
      // TODO
    }
  }

  Future<void> saveImage() async {
    if (selectedImage == null) return;

    final appDir = await p.getApplicationDocumentsDirectory();
    final imageExtension = path.extension(selectedImage!.path);
    final newPath = "${appDir.path}/${DateTime.now().millisecondsSinceEpoch}$imageExtension";
    final copiedFile = await File(selectedImage!.path).copy(newPath);

    log("New Image Path = ${copiedFile.path}");
    await PreferenceManager.setData<String>(StorageKey.userImage, copiedFile.path);
  }

  // ── User data ─────────────────────────────────────────────────────────────
  void loadUserData() async {
    final image = PreferenceManager.getData<String>(StorageKey.userImage);
    username = PreferenceManager.getData<String>(StorageKey.username);
    final String email = PreferenceManager.getData<String>(StorageKey.savedEmail) ?? "";

    usernameController.text = username ?? "";
    emailController.text = email;

    if (image != null) selectedImage = XFile(image);
    safeNotify();
  }

  void updatePersonalInfo() async {
    await PreferenceManager.setData<String>(StorageKey.username, usernameController.text);
    await PreferenceManager.setData<String>(StorageKey.savedEmail, emailController.text);
    username = usernameController.text;
    safeNotify();
  }

  // ── Auth ──────────────────────────────────────────────────────────────────
  void logout(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginView, (route) => false);
    await PreferenceManager.removeKey(StorageKey.isLoggedIn);
  }
}