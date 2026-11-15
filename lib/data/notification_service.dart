import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Сервис для работы с локальными уведомлениями.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Инициализация плагина (вызывается при старте приложения)
  static Future<void> initialize() async {
    // Инициализируем часовые пояса
    tz.initializeTimeZones();

    // ВОТ ЭТА СТРОКА УСТАНАВЛИВАЕТ ЧАСОВОЙ ПОЯС (Москва)
    tz.setLocalLocation(tz.getLocation('Europe/Moscow'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    // Запрашиваем разрешение на уведомления (для Android 13+)
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  /// Планирование уведомления за час до игры
  static Future<void> scheduleGameNotification({
    required int id,
    required String gameName,
    required DateTime gameDateTime,
  }) async {
    // Вычисляем время: за 1 час до игры
    final scheduledTime = gameDateTime.subtract(const Duration(hours: 1));

    // Если время уже прошло, не ставим уведомление
    if (scheduledTime.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      'Скоро игра!',
      'Ваша игра "$gameName" начнется через 1 час. Приготовьтесь к бою!',
      tz.TZDateTime.from(scheduledTime, tz.getLocation('Europe/Moscow')),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'game_channel_id',
          'Game Notifications',
          channelDescription: 'Уведомления о начале игр',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
