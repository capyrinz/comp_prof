import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // <--- ДОБАВИЛИ ИМПОРТ ЛОГГЕРА
import '../../data/session_manager.dart';
import 'onboarding_screen.dart';
import 'landing_screen.dart';
import 'statistics_screen.dart';

/// Экран заставки (Splash Screen).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("[SplashScreen]: Жизненный цикл — initState");
    
    _navigateToNextScreen();
  }

  /// Проверяем сессию и последний экран, затем переходим
  Future<void> _navigateToNextScreen() async {
    // Ждем 2 секунды для красоты
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    // Проверяем, авторизован ли пользователь
    bool isLoggedIn = await SessionManager.isLoggedIn();

    // ВАЖНО: Проверяем mounted после каждого await, чтобы не было ошибки BuildContext
    if (!mounted) return; 

    if (isLoggedIn) {
      // Если авторизован, смотрим последний экран
      String lastScreen = await SessionManager.getLastScreen();
      
      if (!mounted) return; // Проверка перед навигацией

      if (lastScreen == 'statistics') {
        AppLogger.info('SplashScreen', 'Навигация', 'Возврат на экран Статистики');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const StatisticsScreen()),
        );
      } else {
        // По умолчанию - на главный экран
        AppLogger.info('SplashScreen', 'Навигация', 'Возврат на главный экран');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingScreen()),
        );
      }
    } else {
      // Если не авторизован - на онбординг
      AppLogger.info('SplashScreen', 'Навигация', 'Переход на экран приветствия');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    debugPrint("[SplashScreen]: Жизненный цикл — dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports_esports, size: 100, color: AppColors.white),
              const SizedBox(height: 16),
              Text('GAMETIME', style: AppTextStyles.title1ExtraBold.copyWith(color: AppColors.white, letterSpacing: 4)),
              Text('CONNECT WITH YOUR REALITY', style: AppTextStyles.caption2Regular.copyWith(color: AppColors.white.withValues(alpha: 0.8), letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }
}