import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'landing_screen.dart';

class JoinSuccessScreen extends StatelessWidget {
  const JoinSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.white),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingScreen()), (route) => false);
                  },
                ),
              ),
              const Spacer(),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 60, color: AppColors.primary),
              ),
              const SizedBox(height: 32),
              Text(
                'Successfully\nJoin Combat',
                textAlign: TextAlign.center,
                style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white, height: 1.2),
              ),
              const SizedBox(height: 16),
              Text(
                'Wanna know more\ninformation bout this\ncompetition?',
                textAlign: TextAlign.center,
                style: AppTextStyles.captionRegular.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250,
                child: AppButton(
                  text: 'Discover combats',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingScreen()), (route) => false);
                  },
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}