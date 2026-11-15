import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'onboarding_screen.dart'; // Импорт следующего экрана

/// Экран заставки (Splash Screen).
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
    
    // Через 2 секунды переходим на экран Онбординга
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    debugPrint("[SplashScreen]: Жизненный цикл — dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_kabaddi, size: 100, color: AppColors.white),
            const SizedBox(height: 24),
            Text(
              'GAMETIME',
              style: AppTextStyles.title1ExtraBold.copyWith(
                color: AppColors.white,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'CONNECT WITH YOUR REALITY',
              style: AppTextStyles.caption2Regular.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}