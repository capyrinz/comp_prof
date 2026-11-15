import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'registration_screen.dart'; // Импорт экрана регистрации

/// Экран приветствия (Onboarding).
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Get Paid! Playing\nVideo Game",
      "description": "Earn points and real cash when you win a battle with no delay in cashing out",
    },
    {
      "title": "Schedule Games\nWith Friends",
      "description": "Easily create an upcoming event and get ready for battle. Yeah! real combat fella.",
    },
    {
      "title": "Text, Audio and\nVideo Chat",
      "description": "Intuitive real life experience on mobile. Chat with fellow gamers before and after combat for free!",
    },
  ];

  /// Метод для перехода на экран регистрации
  void _goToRegistration() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Кнопка Skip
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToRegistration,
                child: Text(
                  'Skip',
                  style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary),
                ),
              ),
            ),

            // Свайпающиеся страницы
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.inputBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.image, size: 80, color: AppColors.inputIcon),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          _onboardingData[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title2Semibold.copyWith(
                            color: AppColors.primary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _onboardingData[index]["description"]!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textRegular.copyWith(
                            color: AppColors.description,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Точки и кнопка
                        // Точки и кнопка
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Используем наш новый компонент
                  AppPagination(
                    currentIndex: _currentPage,
                    count: _onboardingData.length,
                  ),
                  const SizedBox(height: 32),
                  if (_currentPage == 2)
                    AppButton(
                      text: "Let's Combat!",
                      onPressed: _goToRegistration,
                    )
                  else
                    const SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}