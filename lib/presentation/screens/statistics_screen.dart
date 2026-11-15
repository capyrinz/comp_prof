import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart';
import '../../data/session_manager.dart'; // Импорт SessionManager

/// Экран статистики пользователя (Statistics).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('StatisticsScreen', 'Жизненный цикл', 'Экран статистики открыт (initState)');
    
    // СОХРАНЯЕМ ЭКРАН (Модуль Г)
    SessionManager.saveLastScreen('statistics');
  }

  @override
  void dispose() {
    AppLogger.info('StatisticsScreen', 'Жизненный цикл', 'Экран статистики закрыт (dispose)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text('Statistics', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('THIS WEEK EARNINGS', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$240.00', style: AppTextStyles.title2ExtraBold.copyWith(color: AppColors.white)),
                  const Icon(Icons.timeline, color: AppColors.white, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Played Games', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: 120, width: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const CircularProgressIndicator(value: 1.0, strokeWidth: 15, color: AppColors.inputBg),
                      const CircularProgressIndicator(value: 0.82, strokeWidth: 15, color: AppColors.primary, strokeCap: StrokeCap.round),
                      Center(child: Text('82.3 %', style: AppTextStyles.captionSemibold)),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 12, height: 12, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text('Circle Category', style: AppTextStyles.caption2Regular),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(width: 12, height: 12, color: AppColors.accent),
                        const SizedBox(width: 8),
                        Text('Image Category', style: AppTextStyles.caption2Regular),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Scheduled Games', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(60, 'Mo', true),
                _buildBar(40, 'Tu', false),
                _buildBar(30, 'We', true),
                _buildBar(20, 'Th', false),
                _buildBar(80, 'Fr', true),
                _buildBar(100, 'Sa', false),
                _buildBar(50, 'Su', true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(double height, String label, bool isGradient) {
    return Column(
      children: [
        Container(
          width: 20, height: height,
          decoration: BoxDecoration(
            color: isGradient ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.caption2Regular),
      ],
    );
  }
}