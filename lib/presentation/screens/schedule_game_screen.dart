import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'success_screen.dart'; // Импортируем экран успеха
import '../../data/notification_service.dart';

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
  // Переменные для хранения выбранных значений
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isNotificationEnabled = false;
  final TextEditingController _gameNameController = TextEditingController();

  // Переменная для хранения выбранной категории (для нашего Селекта)
  String? _selectedCategory;

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
        title: Text(
          'Schedule Game',
          style: AppTextStyles.title3Semibold.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Название игры
            AppInput(
              hintText: 'Game Name',
              controller: _gameNameController, // Привязываем контроллер
            ),
            const SizedBox(height: 16),

            // 2. Категория (Используем наш новый AppSelect)
            AppSelect(
              hintText: 'Category',
              selectedValue: _selectedCategory,
              items: const [
                'Image Puzzle',
                'Circle Puzzle',
                'Shooter',
                'Racing',
              ],
              onSelected: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // 3. Призовой фонд
            const AppInput(hintText: 'Winning Price'),
            const SizedBox(height: 24),

            // 4. Выбор даты и времени
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
                          Text(
                            '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                            style: AppTextStyles.textRegular,
                          ),
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
                          Text(
                            _selectedTime.format(context),
                            style: AppTextStyles.textRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Описание
            const AppInput(hintText: 'Description'),
            const SizedBox(height: 24),

            // 6. Чекбокс уведомлений
            Row(
              children: [
                Text(
                  'REMINDERS',
                  style: AppTextStyles.captionSemibold.copyWith(
                    color: AppColors.primary,
                  ),
                ),
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

            // 7. Кнопка публикации
            // 7. Кнопка публикации
            AppButton(
              text: 'Publish',
              onPressed: () async {
                // 1. Если галочка уведомлений стоит, планируем уведомление
                if (_isNotificationEnabled) {
                  final gameDateTime = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );

                  await NotificationService.scheduleGameNotification(
                    id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                    gameName: _gameNameController.text.isEmpty
                        ? 'Combat'
                        : _gameNameController.text,
                    gameDateTime: gameDateTime,
                  );
                  debugPrint("[ScheduleGameScreen]: Уведомление запланировано");
                }

                // 2. Переходим на экран успеха
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
