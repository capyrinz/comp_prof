import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';
// import 'data/notification_service.dart'; // Оставляем на будущее, если нужно
// import 'package:appmetrica_plugin/appmetrica_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Всегда стартуем со Splash
    );
  }
}