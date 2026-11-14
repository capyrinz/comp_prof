import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart'; // Импорт нашей библиотеки

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storybook UI',
      debugShowCheckedModeBanner: false,
      home: const StorybookScreen(),
    );
  }
}

/// Экран витрины (Storybook) для отображения всех компонентов UI-кита.
/// 
/// Дата создания: 14-11-2026
/// Автор создания: [Твой номер]
class StorybookScreen extends StatelessWidget {
  const StorybookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Используем цвет из библиотеки
      appBar: AppBar(
        title: const Text('Storybook (UI Kit)'),
        backgroundColor: AppColors.primary, // Розовый цвет
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Кнопки (Buttons)', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // 1. Активная кнопка
              AppButton(
                text: "Let's Combat!",
                onPressed: () {
                  print("Кнопка нажата!");
                },
              ),
              const SizedBox(height: 16),

              // 2. Неактивная кнопка
              const AppButton(
                text: "Disabled Button",
                state: AppButtonState.disabled,
              ),
              const SizedBox(height: 16),

              // 3. Кнопка загрузки
              const AppButton(
                text: "Loading...",
                state: AppButtonState.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}