import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'success_screen.dart'; // Импортируем экран успеха

/// Экран создания игры (Schedule Game).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class ScheduleGameScreen extends StatefulWidget {
  const ScheduleGameScreen({super.key});

  @override
  State<ScheduleGameScreen> createState() => _ScheduleGameScreenState();
}

class _ScheduleGameScreenState extends State<ScheduleGameScreen> {
  // Переменные для хранения выбранной даты и времени
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isNotificationEnabled = false;

  // Метод для вызова системного календаря
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        // Красим календарь в наш розовый цвет
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Метод для вызова системных часов
  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text('Schedule Game', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppInput(hintText: 'Game Name'),
            const SizedBox(height: 16),
            // Пока используем инпут для категории, потом заменим на Селект
            const AppInput(hintText: 'Category'),
            const SizedBox(height: 16),
            const AppInput(hintText: 'Winning Price'),
            const SizedBox(height: 24),

            // Выбор даты и времени (стилизованные под кнопки)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputLine),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FROM', style: AppTextStyles.caption2Regular),
                          const SizedBox(height: 4),
                          Text('${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}', style: AppTextStyles.textRegular),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickTime(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputLine),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TIME', style: AppTextStyles.caption2Regular),
                          const SizedBox(height: 4),
                          Text(_selectedTime.format(context), style: AppTextStyles.textRegular),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const AppInput(hintText: 'Description'),
            const SizedBox(height: 24),

            // Чекбокс уведомлений
            Row(
              children: [
                Text('REMINDERS', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                const Spacer(),
                AppCheckbox(
                  value: _isNotificationEnabled,
                  onChanged: (val) {
                    setState(() {
                      _isNotificationEnabled = val ?? false;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Text('Notification'),
              ],
            ),
            const SizedBox(height: 40),

            // Кнопка публикации
            AppButton(
              text: 'Publish',
              onPressed: () {
                debugPrint("[ScheduleGameScreen]: Игра опубликована. Переход на Success");
                // Переходим на экран успеха, убирая текущий экран из стека
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}