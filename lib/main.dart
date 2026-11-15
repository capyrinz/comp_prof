import 'package:flutter/material.dart';
import 'data/session_manager.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/landing_screen.dart';
import 'data/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Обязательно
  await NotificationService.initialize();   // Инициализация уведомлений
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ИМЭЧ',
      debugShowCheckedModeBanner: false,
      // Используем FutureBuilder, чтобы дождаться ответа от памяти телефона
      home: FutureBuilder<bool>(
        future: SessionManager.isLoggedIn(),
        builder: (context, snapshot) {
          // Пока грузится память - показываем пустой экран или лоадер
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          
          // Если данные загрузились и пользователь авторизован -> на главный экран
          if (snapshot.data == true) {
            return const LandingScreen();
          }
          
          // Иначе -> на экран заставки (первый запуск)
          return const SplashScreen();
        },
      ),
    );
  }
}