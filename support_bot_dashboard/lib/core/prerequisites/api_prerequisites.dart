import 'package:shared_preferences/shared_preferences.dart';

dynamic getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("access_token");
}

