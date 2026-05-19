import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nova_news/core/datasource/local/preference_manager.dart';

Future<void> initCoreFunctions() async {
  await dotenv.load(fileName: '.env');
  await PreferenceManager.init();
}
