import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'landing_screen.dart';

class GameEndScreen extends StatelessWidget {
  const GameEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Размытый фон (имитация)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 300, height: 200,
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      width: 250, height: 50,
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            ),
            
            // Контент
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100, width: 100,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                    ),
                    child: const Icon(Icons.check, size: 60, color: AppColors.white),
                  ),
                  const SizedBox(height: 24),
                  Text('You Winner', style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white)),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    child: AppButton(
                      text: 'Discover combats',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingScreen()), (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.white),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingScreen()), (route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}