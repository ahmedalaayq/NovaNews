import 'package:flutter/material.dart';
import 'package:nova_news/core/app/nova_news.dart';

import 'core/functions/init_core_function.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initCoreFunctions();
  runApp(NovaNews());
}


