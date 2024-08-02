import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/secure_storage.dart';

final SecureStorage _storage = serviceLocator<SecureStorage>();
String? accessToken;

dynamic getToken() async {
  accessToken = await _storage.getString(key: SecureStorageKey.accessToken);
  return accessToken;
}
