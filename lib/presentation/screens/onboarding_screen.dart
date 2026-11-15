import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'registration_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {"title": "Get Paid! Playing\nVideo Game", "description": "Earn points and real cash when you win a battle with no delay in cashing out", "icon": Icons.monetization_on},
    {"title": "Schedule Games\nWith Friends", "description": "Easily create an upcoming event and get ready for battle. Yeah! real combat fella.", "icon": Icons.calendar_month},
    {"title": "Text, Audio and\nVideo Chat", "description": "Intuitive real life experience on mobile. Chat with fellow gamers before and after combat for free!", "icon": Icons.chat_bubble},
  ];

  void _goToRegistration() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment: Alignment.topRight, child: TextButton(onPressed: _goToRegistration, child: Text('Skip', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)))),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_onboardingData[index]["icon"], size: 200, color: AppColors.primary.withValues(alpha: 0.2)),
                        const SizedBox(height: 40),
                        Text(_onboardingData[index]["title"]!, textAlign: TextAlign.center, style: AppTextStyles.title2Semibold.copyWith(color: AppColors.primary, height: 1.2)),
                        const SizedBox(height: 20),
                        Text(_onboardingData[index]["description"]!, textAlign: TextAlign.center, style: AppTextStyles.textRegular.copyWith(color: AppColors.black, height: 1.5)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  AppPagination(currentIndex: _currentPage, count: _onboardingData.length),
                  const SizedBox(height: 32),
                  if (_currentPage == 2) AppButton(text: "Let's Combat!", onPressed: _goToRegistration) else const SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}