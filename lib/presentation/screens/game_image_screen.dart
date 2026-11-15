import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart';
import 'game_end_screen.dart';

/// Экран игры Image (Пазл/Пятнашки).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class GameImageScreen extends StatefulWidget {
  const GameImageScreen({super.key});

  @override
  State<GameImageScreen> createState() => _GameImageScreenState();
}

class _GameImageScreenState extends State<GameImageScreen> with WidgetsBindingObserver {
  List<int> _pieces = [1, 2, 3, 4, 5, 6, 7, 8, 0]; 
  int _seconds = 0;
  Timer? _timer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppLogger.info('GameImageScreen', 'Жизненный цикл', 'Игра Image запущена (initState)');
    _shufflePuzzle();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    AppLogger.info('GameImageScreen', 'Жизненный цикл', 'Игра Image закрыта (dispose)');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Если игрок свернул приложение и игра идет
    if (state == AppLifecycleState.paused && _isPlaying) {
      AppLogger.error('GameImageScreen', 'Проигрыш', 'Игрок свернул приложение во время игры');
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
    
    bool isAdjacent = (index == emptyIndex - 1 && index % 3 != 2) || 
                      (index == emptyIndex + 1 && index % 3 != 0) ||
                      (index == emptyIndex - 3) || 
                      (index == emptyIndex + 3);

    if (isAdjacent) {
      setState(() {
        int temp = _pieces[index];
        _pieces[index] = 0;
        _pieces[emptyIndex] = temp;
      });

      AppLogger.debug('GameImageScreen', 'Движение пазла', 'Передвинут кусочек');

      if (isSolved()) {
        _timer?.cancel();
        _isPlaying = false;
        
        AppLogger.info('GameImageScreen', 'Победа', 'Пазл собран! Время: $_formattedTime');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GameEndScreen()),
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
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1, 
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
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // 1. ЦИФРА (лежит на заднем фоне, видна всегда)
                                          Container(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            child: Center(
                                              child: Text(
                                                '$value',
                                                style: AppTextStyles.title1ExtraBold.copyWith(
                                                  color: AppColors.primary,
                                                  fontSize: tileSize / 2.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          
                                          // 2. КАРТИНКА (перекрывает цифру, если загрузилась)
                                          Transform.translate(
                                            offset: Offset(-imageCol * tileSize, -imageRow * tileSize),
                                            child: Image.asset(
                                              'assets/images/puzzle.jpg',
                                              width: tileSize * 3,
                                              height: tileSize * 3,
                                              fit: BoxFit.cover,
                                              // Если картинки нет - возвращаем пустоту, и мы увидим цифру под ней
                                              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
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
                AppLogger.info('GameImageScreen', 'Пользовательский ввод', 'Игрок сдался (Surrender)');
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