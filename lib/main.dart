import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

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
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class StorybookScreen extends StatefulWidget {
  const StorybookScreen({super.key});

  @override
  State<StorybookScreen> createState() => _StorybookScreenState();
}

class _StorybookScreenState extends State<StorybookScreen> {
  // Состояние для нашего чекбокса
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Storybook (UI Kit)'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Кнопки (Buttons)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              AppButton(
                text: "Let's Combat!",
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              
              const Text('Поля ввода (Inputs)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const AppInput(hintText: 'Full Name'),
              const SizedBox(height: 24),
              const AppInput(hintText: 'Email', errorText: 'Incorrect email format'),
              
              const SizedBox(height: 32),
              const Text('Другие компоненты (Other)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              // Таймер
              const AppTimer(time: "00:00"),
              const SizedBox(height: 24),

              // Карточка
              const AppCard(
                title: "Schedule",
                description: "Easily schedule event/games then find like minded players for battle.",
              ),
              const SizedBox(height: 24),

              // Чекбокс (с логикой)
              Row(
                children: [
                  AppCheckbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = val ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  const Text('I agree to the terms and conditions'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}