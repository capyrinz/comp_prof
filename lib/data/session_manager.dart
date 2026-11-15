import 'package:shared_preferences/shared_preferences.dart';

/// Класс для управления сессией пользователя и сохранения состояния.
class SessionManager {
  static const String _keyIsLoggedIn = 'is_logged_in';

  /// Сохраняем статус входа
  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  /// Проверяем, авторизован ли пользователь
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Очищаем сессию (для кнопки Logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}