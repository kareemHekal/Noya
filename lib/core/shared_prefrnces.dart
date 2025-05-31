import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _baseUrlKey = 'base_url';
  static const String _darkModeKey = 'dark_mode';
  static const String _isLoggedKey = 'is_logged';

  static Future<void> saveBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_baseUrlKey, url);
  }

  static Future<String?> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_baseUrlKey);
  }

  static Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  static Future<bool?> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey);
  }

  // ✅ Add these for isLogged
  static Future<void> saveIsLogged(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, value);
  }

  static Future<bool?> getIsLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedKey);
  }
}
