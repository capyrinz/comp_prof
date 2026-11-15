import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'success_screen.dart';

/// Экран игры Image (Пазл/Пятнашки).
class GameImageScreen extends StatefulWidget {
  const GameImageScreen({super.key});

  @override
  State<GameImageScreen> createState() => _GameImageScreenState();
}

class _GameImageScreenState extends State<GameImageScreen> {
  List<int> _pieces = [1, 2, 3, 4, 5, 6, 7, 8, 0]; 
  int _seconds = 0;
  Timer? _timer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _shufflePuzzle();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _shufflePuzzle() {
    setState(() {
      _pieces = [1, 2, 3, 4, 5, 6, 7, 8, 0];
      for (int i = 0; i < 50; i++) {
        int emptyIndex = _pieces.indexOf(0);
        List<int> validMoves = [];
        
        if (emptyIndex - 3 >= 0) validMoves.add(emptyIndex - 3); 
        if (emptyIndex + 3 < 9) validMoves.add(emptyIndex + 3); 
        if (emptyIndex % 3 != 0) validMoves.add(emptyIndex - 1); 
        if (emptyIndex % 3 != 2) validMoves.add(emptyIndex + 1); 

        int moveIndex = validMoves[Random().nextInt(validMoves.length)];
        
        int temp = _pieces[moveIndex];
        _pieces[moveIndex] = 0;
        _pieces[emptyIndex] = temp;
      }
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

  bool isSolved() {
    for (int i = 0; i < _pieces.length; i++) {
      if (_pieces[i] != (i + 1) % 9) return false;
    }
    return true;
  }

  void _onTileTap(int index) {
    if (!_isPlaying) return;

    int emptyIndex = _pieces.indexOf(0);
    
    // Проверяем, можно ли передвинуть ячейку
    bool isAdjacent = (index == emptyIndex - 1 && index % 3 != 2) || 
                      (index == emptyIndex + 1 && index % 3 != 0) ||
                      (index == emptyIndex - 3) || 
                      (index == emptyIndex + 3);

    // Выводим в консоль для отладки
    debugPrint("Нажата ячейка $index. Пустая ячейка: $emptyIndex. Можно двигать: $isAdjacent");

    if (isAdjacent) {
      setState(() {
        int temp = _pieces[index];
        _pieces[index] = 0;
        _pieces[emptyIndex] = temp;
      });

      if (isSolved()) {
        _timer?.cancel();
        _isPlaying = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
        );
      }
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
        title: Text('Game Image', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppTimer(time: _formattedTime),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category: Image', style: AppTextStyles.captionRegular),
                Text('Hint: Puzzle', style: AppTextStyles.captionRegular.copyWith(color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 16),

            // Игровое поле
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1, // Квадратное поле
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double tileSize = constraints.maxWidth / 3;

                          return Stack(
                            children: List.generate(9, (index) {
                              final value = _pieces[index];
                              if (value == 0) return const SizedBox.shrink();

                              final int currentRow = index ~/ 3;
                              final int currentCol = index % 3;
                              final int imageRow = (value - 1) ~/ 3;
                              final int imageCol = (value - 1) % 3;

                              return Positioned(
                                left: currentCol * tileSize,
                                top: currentRow * tileSize,
                                width: tileSize,
                                height: tileSize,
                                child: GestureDetector(
                                  onTap: () => _onTileTap(index),
                                  child: Container(
                                    margin: const EdgeInsets.all(2), // Отступ между плитками
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.1), // Фон, если нет картинки
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.primary, width: 1),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // Пытаемся загрузить картинку
                                          Transform.translate(
                                            offset: Offset(-imageCol * tileSize, -imageRow * tileSize),
                                            child: Image.asset(
                                              'assets/puzzle.jpg',
                                              width: tileSize * 3,
                                              height: tileSize * 3,
                                              fit: BoxFit.cover,
                                              // Если картинки нет, скрываем её
                                              errorBuilder: (context, error, stackTrace) {
                                                return const SizedBox.shrink(); 
                                              },
                                            ),
                                          ),
                                          // Цифра (показывается всегда, но картинка перекрывает её, если загрузилась)
                                          Center(
                                            child: Text(
                                              '$value',
                                              style: AppTextStyles.title1ExtraBold.copyWith(
                                                color: AppColors.primary,
                                                fontSize: 32,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            AppButton(
              text: 'Surrender',
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),
    );
  }
}