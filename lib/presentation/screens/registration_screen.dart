import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                'Create Account',
                style: AppTextStyles.title2Semibold.copyWith(color: AppColors.primary),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.inputBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.image, size: 60, color: AppColors.inputIcon),
                    ),
                    const SizedBox(height: 24),
                    Text('Create Account', style: AppTextStyles.title3Semibold),
                    const SizedBox(height: 8),
                    Text(
                      'Hi, kindly fill in the form to proceed combat',
                      style: AppTextStyles.captionRegular.copyWith(color: AppColors.description),
                    ),
                    const SizedBox(height: 24),
                    const AppInput(hintText: 'Full Name'),
                    const SizedBox(height: 16),
                    const AppInput(hintText: 'User Name'),
                    const SizedBox(height: 16),
                    const AppInput(hintText: '+234  Your Phone'),
                    const SizedBox(height: 16),
                    const AppInput(hintText: 'Email'),
                    const SizedBox(height: 16),
                    const AppInput(hintText: 'Password', obscureText: true),
                    const SizedBox(height: 16),
                    const AppInput(hintText: 'Confirm Password', obscureText: true),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Create Account',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ', style: AppTextStyles.captionRegular),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            },
                            child: Text('Login', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}