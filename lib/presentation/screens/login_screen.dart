import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт для логгера
import 'landing_screen.dart';

/// Класс отвечает за отображение экрана авторизации и обработку ввода данных пользователя.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Состояние для глазика

  // 1. ЛОГИРУЕМ ОТКРЫТИЕ ЭКРАНА (Требование Модуля А)
  @override
  void initState() {
    super.initState();
    AppLogger.info('LoginScreen', 'Жизненный цикл', 'Экран авторизации открыт (initState)');
  }

  // 2. ЛОГИРУЕМ ЗАКРЫТИЕ ЭКРАНА (Требование Модуля А)
  @override
  void dispose() {
    AppLogger.info('LoginScreen', 'Жизненный цикл', 'Экран авторизации закрыт (dispose)');
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // 3. ЛОГИРУЕМ НАЖАТИЕ КНОПКИ (Требование Модуля А)
    AppLogger.info('LoginScreen', 'Пользовательский ввод', 'Нажата кнопка "Let\'s Combat!"');

    setState(() { _isLoading = true; });
    
    // Имитация запроса к серверу (пока без реального бэкенда)
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
    
    if (mounted) setState(() { _isLoading = false; });
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
              // Легкая заглушка вместо тяжелой картинки
              Center(
                child: Container(
                  height: 200, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1), 
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Icon(Icons.sports_esports, size: 80, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 32),
              
              Text('Welcome Back!', style: AppTextStyles.title2Semibold.copyWith(color: AppColors.primary)),
              const SizedBox(height: 8),
              Text('Hi, kindly login to continue battle', style: AppTextStyles.captionRegular.copyWith(color: AppColors.black)),
              const SizedBox(height: 32),

              const AppInput(hintText: 'Email'),
              const SizedBox(height: 16),
              
              // ПАРОЛЬ С ГЛАЗИКОМ
              AppInput(
                hintText: 'Password',
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.inputIcon),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forget Password?', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.black)),
                ),
              ),
              const SizedBox(height: 16),

              _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : AppButton(text: "Let's Combat!", onPressed: _handleLogin),
              
              const SizedBox(height: 32),

              // Соцсети (легкие иконки)
              Center(
                child: Column(
                  children: [
                    Text('Connect With:', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(backgroundColor: AppColors.error, radius: 20, child: const Icon(Icons.g_mobiledata, color: Colors.white, size: 30)),
                        const SizedBox(width: 16),
                        CircleAvatar(backgroundColor: AppColors.accent, radius: 20, child: const Icon(Icons.facebook, color: Colors.white, size: 30)),
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
                    Text("Don't have an account? ", style: AppTextStyles.captionRegular),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text('Create Account', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
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