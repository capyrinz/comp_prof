import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'landing_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Круг с галочкой
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.black.withValues(alpha: 0.1), blurRadius: 20)
                  ]
                ),
                child: const Icon(Icons.check, size: 80, color: AppColors.primary),
              ),
              const SizedBox(height: 32),
              Text(
                'Published\nSuccessful',
                textAlign: TextAlign.center,
                style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white, height: 1.2, fontSize: 32),
              ),
              const SizedBox(height: 16),
              Text(
                'Wanna change/edit your\nscheduled game before it begins?',
                textAlign: TextAlign.center,
                style: AppTextStyles.captionRegular.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250,
                child: AppButton(
                  text: 'Statistics',
                  onPressed: () {
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