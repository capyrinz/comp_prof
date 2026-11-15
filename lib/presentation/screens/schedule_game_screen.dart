import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'success_screen.dart';
import '../../data/notification_service.dart';

/// Класс отвечает за создание игры, выбор даты, времени и настройку уведомлений.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class ScheduleGameScreen extends StatefulWidget {
  const ScheduleGameScreen({super.key});

  @override
  State<ScheduleGameScreen> createState() => _ScheduleGameScreenState();
}

class _ScheduleGameScreenState extends State<ScheduleGameScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isNotificationEnabled = false;
  String? _selectedCategory;
  final TextEditingController _gameNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppLogger.info('ScheduleGameScreen', 'Жизненный цикл', 'Экран создания игры открыт (initState)');
  }

  @override
  void dispose() {
    _gameNameController.dispose();
    AppLogger.info('ScheduleGameScreen', 'Жизненный цикл', 'Экран создания игры закрыт (dispose)');
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    AppLogger.debug('ScheduleGameScreen', 'Пользовательский ввод', 'Открыт системный календарь');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() { _selectedDate = picked; });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    AppLogger.debug('ScheduleGameScreen', 'Пользовательский ввод', 'Открыт системный выбор времени');
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
      setState(() { _selectedTime = picked; });
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
            AppInput(hintText: 'Game Name', controller: _gameNameController),
            const SizedBox(height: 16),
            
            AppSelect(
              hintText: 'Category',
              selectedValue: _selectedCategory,
              items: const ['Image Puzzle', 'Circle Puzzle', 'Shooter', 'Racing'],
              onSelected: (value) {
                AppLogger.debug('ScheduleGameScreen', 'Пользовательский ввод', 'Выбрана категория: $value');
                setState(() { _selectedCategory = value; });
              },
            ),
            const SizedBox(height: 16),
            
            const AppInput(hintText: 'Winning Price'),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.inputLine), borderRadius: BorderRadius.circular(8)),
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
                      decoration: BoxDecoration(border: Border.all(color: AppColors.inputLine), borderRadius: BorderRadius.circular(8)),
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

            Row(
              children: [
                Text('REMINDERS', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                const Spacer(),
                AppCheckbox(
                  value: _isNotificationEnabled,
                  onChanged: (val) {
                    AppLogger.debug('ScheduleGameScreen', 'Пользовательский ввод', 'Уведомления переключены: $val');
                    setState(() { _isNotificationEnabled = val ?? false; });
                  },
                ),
                const SizedBox(width: 8),
                const Text('Notification'),
              ],
            ),
            const SizedBox(height: 40),

            AppButton(
              text: 'Publish',
              onPressed: () async {
                AppLogger.info('ScheduleGameScreen', 'Пользовательский ввод', 'Нажата кнопка "Publish". Создание игры.');
                
                if (_isNotificationEnabled) {
                  final gameDateTime = DateTime(
                    _selectedDate.year, _selectedDate.month, _selectedDate.day,
                    _selectedTime.hour, _selectedTime.minute,
                  );
                  await NotificationService.scheduleGameNotification(
                    id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                    gameName: _gameNameController.text.isEmpty ? 'Combat' : _gameNameController.text,
                    gameDateTime: gameDateTime,
                  );
                  AppLogger.info('ScheduleGameScreen', 'Уведомление', 'Уведомление успешно запланировано');
                }

                if (mounted) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SuccessScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}