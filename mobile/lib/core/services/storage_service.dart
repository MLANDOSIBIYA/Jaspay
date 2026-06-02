import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: "auth_token", value: token);

    await _storage.write(
      key: "login_time",
      value: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }

  static Future<bool> isSessionValid() async {
    final loginTime = await _storage.read(key: "login_time");

    if (loginTime == null) {
      return false;
    }

    final saved = DateTime.fromMillisecondsSinceEpoch(int.parse(loginTime));

    final difference = DateTime.now().difference(saved);

    return difference.inMinutes < 5;
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: "auth_token");

    await _storage.delete(key: "login_time");
  }
}
