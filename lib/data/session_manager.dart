import 'package:shared_preferences/shared_preferences.dart';

/// Класс для управления сессией пользователя и сохранения состояния.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class SessionManager {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyLastScreen = 'last_screen'; // Новый ключ

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

  /// Сохраняем последний открытый экран
  static Future<void> saveLastScreen(String screenName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastScreen, screenName);
  }

  /// Получаем последний открытый экран (по умолчанию 'landing')
  static Future<String> getLastScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastScreen) ?? 'landing'; 
  }

  /// Очищаем сессию (для кнопки Logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}