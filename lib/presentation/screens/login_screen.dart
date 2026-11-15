import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'landing_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.inputBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.image,
                  size: 60,
                  color: AppColors.inputIcon,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome Back!',
                style: AppTextStyles.title2Semibold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hi, kindly login to continue battle',
                style: AppTextStyles.captionRegular.copyWith(
                  color: AppColors.description,
                ),
              ),
              const SizedBox(height: 32),
              const AppInput(hintText: 'Email'),
              const SizedBox(height: 16),
              const AppInput(hintText: 'Password', obscureText: true),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password?',
                    style: AppTextStyles.captionSemibold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Let's Combat!",
                onPressed: () {
                  // Переходим на главный экран
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Connect With:',
                      style: AppTextStyles.captionSemibold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.error,
                          radius: 20,
                          child: const Icon(
                            Icons.g_mobiledata,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          backgroundColor: AppColors.accent,
                          radius: 20,
                          child: const Icon(
                            Icons.facebook,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.captionRegular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Create Account',
                        style: AppTextStyles.captionSemibold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
