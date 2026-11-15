import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'game_image_screen.dart';
import 'game_circle_screen.dart';

/// Экран с подробной информацией о выбранном бое (Combat Information).
///
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class CombatInformationScreen extends StatelessWidget {
  const CombatInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text(
          'Combat\nInformation',
          style: AppTextStyles.title3Semibold.copyWith(
            color: AppColors.primary,
            height: 1.1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карточка с игроками
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NFTs (Evolve 2)',
                        style: AppTextStyles.captionSemibold,
                      ),
                      Text(
                        '\$4000',
                        style: AppTextStyles.captionSemibold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlayerAvatar('Guy Hawkins', true),
                      Text(
                        'VS',
                        style: AppTextStyles.title2ExtraBold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      _buildPlayerAvatar('Travis Black', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Правила игры
            Text(
              'If players haven\'t join / need 6 valid gamers to join me on this quest playing NFT (Evolve 2) you will be rewarded depending on position. Let\'s win some money. Are you ready for this challenge? let\'s really',
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.description,
              ),
            ),
            const SizedBox(height: 24),

            // Категория
            Text(
              'Category',
              style: AppTextStyles.captionSemibold.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('Image', style: AppTextStyles.captionRegular),
            ),
            const SizedBox(height: 24),

            // Призовой фонд
            Row(
              children: [
                Text(
                  'Winning\nPrice',
                  style: AppTextStyles.captionSemibold.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 24),
                Text('\$2000', style: AppTextStyles.textMedium),
                const SizedBox(width: 24),
                Text('\$500', style: AppTextStyles.textMedium),
                const SizedBox(width: 24),
                Text('\$500', style: AppTextStyles.textMedium),
              ],
            ),
            const SizedBox(height: 24),

            // Временной интервал
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputLine),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TIME INTERVAL',
                        style: AppTextStyles.captionSemibold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTimeRow('FROM', 'MON, NOV 4, 2019', '12:30 AM'),
                  const SizedBox(height: 12),
                  _buildTimeRow('TO', 'MON, NOV 4, 2019', '12:30 AM'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Кнопка присоединиться
                        AppButton(
              text: 'Join Combat!',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameImageScreen()),
                );
              },
            ),
            const SizedBox(height: 16), // Отступ
            // ВРЕМЕННАЯ КНОПКА ДЛЯ ТЕСТА ИГРЫ CIRCLE
            AppButton(
              text: 'Играть в Circle (Тест)',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameCircleScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerAvatar(String name, bool isBlue) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: isBlue ? AppColors.accent : AppColors.black,
          child: const Icon(Icons.person, color: AppColors.white),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.caption2Regular.copyWith(fontSize: 10)),
      ],
    );
  }

  Widget _buildTimeRow(String label, String date, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.caption2Regular.copyWith(
            color: AppColors.primary,
          ),
        ),
        Text(date, style: AppTextStyles.caption2Regular),
        Text(time, style: AppTextStyles.caption2Regular),
      ],
    );
  }
}
