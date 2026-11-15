import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'success_screen.dart';

/// Экран игры Circle (Собери круги от большего к меньшему).
class GameCircleScreen extends StatefulWidget {
  const GameCircleScreen({super.key});

  @override
  State<GameCircleScreen> createState() => _GameCircleScreenState();
}

class _GameCircleScreenState extends State<GameCircleScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isPlaying = false;

  // Размеры кругов и их позиции (сгруппированы, чтобы не перекрывались)
  final List<Map<String, dynamic>> _circles = [
    {'size': 120.0, 'align': const Alignment(-0.5, -0.6), 'number': 1}, // Самый большой
    {'size': 90.0,  'align': const Alignment(0.6, -0.3),  'number': 2},
    {'size': 70.0,  'align': const Alignment(-0.4, 0.4),  'number': 3},
    {'size': 50.0,  'align': const Alignment(0.7, 0.6),   'number': 4},
    {'size': 30.0,  'align': const Alignment(0.0, 0.0),   'number': 5}, // Самый маленький
  ];
  
  // Список оставшихся номеров (какие круги еще не собраны)
  List<int> _remainingNumbers = [];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      // Все круги на месте
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

    // Находим самый маленький номер из оставшихся (1 - самый большой, 5 - самый маленький)
    // Игрок должен нажимать 1, потом 2, потом 3...
    int expectedNumber = _remainingNumbers.reduce((a, b) => a < b ? a : b);

    if (number == expectedNumber) {
      // Правильный выбор!
      setState(() {
        _remainingNumbers.remove(number);
      });

      // Если собрали все круги
      if (_remainingNumbers.isEmpty) {
        _timer?.cancel();
        _isPlaying = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
        );
      }
    } else {
      // Ошибка! Штрафуем на 3 секунды
      setState(() {
        _seconds += 3;
      });
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

          // Игровое поле
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

                    // Если круг уже собран, не отображаем его
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
                                fontSize: size / 2.5, // Размер шрифта зависит от размера круга
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