import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart';
import 'game_end_screen.dart';

/// Экран игры Circle (Собери круги от большего к меньшему).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class GameCircleScreen extends StatefulWidget {
  const GameCircleScreen({super.key});

  @override
  State<GameCircleScreen> createState() => _GameCircleScreenState();
}

// Добавляем WidgetsBindingObserver для отслеживания жизненного цикла приложения
class _GameCircleScreenState extends State<GameCircleScreen> with WidgetsBindingObserver {
  int _seconds = 0;
  Timer? _timer;
  bool _isPlaying = false;

  final List<Map<String, dynamic>> _circles = [
    {'size': 120.0, 'align': const Alignment(-0.5, -0.6), 'number': 1},
    {'size': 90.0,  'align': const Alignment(0.6, -0.3),  'number': 2},
    {'size': 70.0,  'align': const Alignment(-0.4, 0.4),  'number': 3},
    {'size': 50.0,  'align': const Alignment(0.7, 0.6),   'number': 4},
    {'size': 30.0,  'align': const Alignment(0.0, 0.0),   'number': 5}, 
  ];
  
  List<int> _remainingNumbers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Регистрируем наблюдателя
    AppLogger.info('GameCircleScreen', 'Жизненный цикл', 'Игра Circle запущена (initState)');
    _startGame();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Удаляем наблюдателя
    _timer?.cancel();
    AppLogger.info('GameCircleScreen', 'Жизненный цикл', 'Игра Circle закрыта (dispose)');
    super.dispose();
  }

  // НОВЫЙ МЕТОД: Отслеживаем сворачивание приложения (Модуль Г)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isPlaying) {
      // Игрок свернул приложение во время игры - засчитываем поражение
      AppLogger.error('GameCircleScreen', 'Проигрыш', 'Игрок свернул приложение во время игры');
      _timer?.cancel();
      _isPlaying = false;
      
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Вы проиграли!'),
            content: const Text('Нельзя сворачивать приложение во время боя.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Закрываем диалог
                  Navigator.pop(context); // Выходим из игры назад
                },
                child: const Text('Выйти'),
              )
            ],
          ),
        );
      }
    }
  }

  void _startGame() {
    setState(() {
      _remainingNumbers = [1, 2, 3, 4, 5];
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 0;
    _isPlaying = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() { _seconds++; });
      }
    });
  }

  String get _formattedTime {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onCircleTap(int number) {
    if (!_isPlaying) return;

    int expectedNumber = _remainingNumbers.reduce((a, b) => a < b ? a : b);

    if (number == expectedNumber) {
      AppLogger.debug('GameCircleScreen', 'Движение', 'Собран правильный круг №$number');
      
      setState(() {
        _remainingNumbers.remove(number);
      });

      if (_remainingNumbers.isEmpty) {
        _timer?.cancel();
        _isPlaying = false;
        
        AppLogger.info('GameCircleScreen', 'Победа', 'Все круги собраны! Время: $_formattedTime');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GameEndScreen()),
        );
      }
    } else {
      setState(() {
        _seconds += 3;
      });
      
      AppLogger.error('GameCircleScreen', 'Ошибка', 'Игрок нажал не на тот круг (нужен $expectedNumber, нажат $number)');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Неверно! Нужен следующий по размеру круг. +3 сек штрафа'),
          duration: Duration(milliseconds: 800),
          backgroundColor: AppColors.error,
        ),
      );
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
        title: Text('Game Circle', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                AppTimer(time: _formattedTime),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Category: Circle', style: AppTextStyles.captionRegular),
                    Text('Tap from 1 to 5', style: AppTextStyles.captionRegular.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: _circles.map((circle) {
                    final int number = circle['number'];
                    final double size = circle['size'];
                    final Alignment align = circle['align'];

                    if (!_remainingNumbers.contains(number)) {
                      return const SizedBox.shrink();
                    }

                    return Align(
                      alignment: align,
                      child: GestureDetector(
                        onTap: () => _onCircleTap(number),
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                            border: Border.all(color: AppColors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ]
                          ),
                          child: Center(
                            child: Text(
                              '$number',
                              style: AppTextStyles.title1ExtraBold.copyWith(
                                color: AppColors.white,
                                fontSize: size / 2.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: AppButton(
              text: 'Surrender',
              onPressed: () {
                AppLogger.info('GameCircleScreen', 'Пользовательский ввод', 'Игрок сдался (Surrender)');
                _timer?.cancel();
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}