import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ИМЭЧ',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // <--- ГЛАВНАЯ СТРОКА. Тут должен быть SplashScreen
    );
  }
}