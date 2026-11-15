import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'login_screen.dart';

/// Класс отвечает за отображение экрана регистрации и валидацию полей.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('RegistrationScreen', 'Жизненный цикл', 'Экран регистрации открыт (initState)');
  }

  @override
  void dispose() {
    AppLogger.info('RegistrationScreen', 'Жизненный цикл', 'Экран регистрации закрыт (dispose)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text('Create Account', style: AppTextStyles.title2Semibold.copyWith(color: AppColors.primary)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 120, width: 120,
                          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: const Icon(Icons.person_add_alt_1, size: 60, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Create Account', style: AppTextStyles.title3Semibold),
                      const SizedBox(height: 8),
                      Text('Hi, kindly fill in the form to proceed combat', style: AppTextStyles.captionRegular.copyWith(color: AppColors.black)),
                      const SizedBox(height: 24),
                      
                      const AppInput(hintText: 'Full Name'),
                      const SizedBox(height: 16),
                      const AppInput(hintText: 'User Name'),
                      const SizedBox(height: 16),
                      const AppInput(hintText: '+234  Your Phone'),
                      const SizedBox(height: 16),
                      
                      AppInput(
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Введите email';
                          final emailRegex = RegExp(r'^[a-z0-9]+@[a-z0-9]+\.ru$');
                          if (!emailRegex.hasMatch(value)) return 'Неверный формат (name@domenname.ru)';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      AppInput(
                        hintText: 'Password',
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.inputIcon),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      AppInput(
                        hintText: 'Confirm Password',
                        obscureText: !_isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.inputIcon),
                          onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      AppButton(
                        text: 'Create Account',
                        onPressed: () {
                          // ЛОГ НАЖАТИЯ
                          AppLogger.info('RegistrationScreen', 'Пользовательский ввод', 'Нажата кнопка "Create Account"');
                          
                          if (_formKey.currentState!.validate()) {
                            AppLogger.debug('RegistrationScreen', 'Валидация', 'Все поля заполнены верно');
                            // TODO: Логика регистрации
                          } else {
                            AppLogger.error('RegistrationScreen', 'Валидация', 'Ошибка валидации полей');
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? ', style: AppTextStyles.captionRegular),
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
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
            ),
          ],
        ),
      ),
    );
  }
}