import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Экран статистики пользователя (Statistics).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

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
            // Блок 1: Заработок
            Text('THIS WEEK EARNINGS', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary, // Используем градиент из UI-кита
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$240.00', style: AppTextStyles.title2ExtraBold.copyWith(color: AppColors.white)),
                  // Имитация графика (волнистая линия)
                  const Icon(Icons.show_chart, color: AppColors.white, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Блок 2: Игры
            Text('Played Games', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 16),
            Row(
              children: [
                // Имитация круговой диаграммы (Donut Chart)
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.inputLine, width: 12),
                  ),
                  child: Center(
                    child: Text('82.3 %', style: AppTextStyles.captionSemibold),
                  ),
                ),
                const SizedBox(width: 32),
                // Легенда
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

            // Блок 3: Запланированные игры (Bar Chart)
            Text('Scheduled Games', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(40, 'Mo'),
                _buildBar(60, 'Tu'),
                _buildBar(30, 'We'),
                _buildBar(80, 'Th'),
                _buildBar(50, 'Fr'),
                _buildBar(90, 'Sa'),
                _buildBar(20, 'Su'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Вспомогательный метод для отрисовки столбиков (Bar Chart)
  Widget _buildBar(double height, String label) {
    return Column(
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            color: height > 50 ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.caption2Regular),
      ],
    );
  }
}