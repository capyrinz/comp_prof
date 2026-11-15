import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart';

import '../../data/auth_repository.dart';
import 'landing_screen.dart';
import '../../data/session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // Создаем клиент и репозиторий (пока с фейковым URL для теста)
  final _authRepo = AuthRepository(
    ApiClient(baseUrl: 'https://fake-api-imech.com'),
  );

  void _showErrorNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 5), // Требование: 5 секунд
        action: SnackBarAction(
          label: 'X', // Кнопка закрытия
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // СОХРАНЯЕМ СЕССИЮ
      await SessionManager.saveLoginStatus(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

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
              // ... (картинка и тексты остаются как были) ...
              const SizedBox(
                height: 200,
                child: Center(child: Text('Картинка')),
              ),
              Text(
                'Welcome Back!',
                style: AppTextStyles.title2Semibold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),

              const AppInput(hintText: 'Email'),
              const SizedBox(height: 16),
              const AppInput(hintText: 'Password', obscureText: true),

              const SizedBox(height: 32),

              // Кнопка теперь показывает загрузку, если идет запрос
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : AppButton(text: "Let's Combat!", onPressed: _handleLogin),

              // ... (остальной код с соцсетями) ...
            ],
          ),
        ),
      ),
    );
  }
}
