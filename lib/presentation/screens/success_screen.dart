import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'landing_screen.dart';

/// Экран успешного создания игры (Success Message).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Розовый фон
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Круг с галочкой
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 60, color: AppColors.primary),
              ),
              const SizedBox(height: 32),
              Text(
                'Published\nSuccessful',
                textAlign: TextAlign.center,
                style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white, height: 1.2),
              ),
              const SizedBox(height: 16),
              Text(
                'Wanna change/edit your\nscheduled game before it begins?',
                textAlign: TextAlign.center,
                style: AppTextStyles.captionRegular.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
              ),
              const SizedBox(height: 40),
              
              // Кнопка возврата
              SizedBox(
                width: 200,
                child: AppButton(
                  text: 'Statistics', // В макете кнопка называется Statistics
                  onPressed: () {
                    debugPrint("[SuccessScreen]: Возврат на Landing Screen");
                    // Возвращаемся на главный экран (очищая стек навигации)
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LandingScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}