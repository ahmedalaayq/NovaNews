import 'package:nova_news/core/datasource/local/preference_manager.dart';

Future<void> initCoreFunctions() async {
  await PreferenceManager.init();
}
