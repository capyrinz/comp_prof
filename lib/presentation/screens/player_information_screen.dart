import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Экран с информацией об игроке (Player Information).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class PlayerInformationScreen extends StatelessWidget {
  const PlayerInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text('Player\nInformation', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary, height: 1.1)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карточка профиля
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.black,
                    child: Icon(Icons.person, size: 40, color: AppColors.white),
                  ),
                  const SizedBox(height: 12),
                  Text('Scott Brown', style: AppTextStyles.title3Semibold),
                  const SizedBox(height: 4),
                  Text('LvL 03', style: AppTextStyles.caption2Regular),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('Earned', '\$500'),
                      _buildStat('Played', '\$500'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.military_tech, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text('Gold Player', style: AppTextStyles.captionSemibold.copyWith(color: Colors.amber)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Категории
            Row(
              children: [
                Text('Category', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.inputBg, borderRadius: BorderRadius.circular(12)),
                  child: Text('Image', style: AppTextStyles.caption2Regular),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.inputBg, borderRadius: BorderRadius.circular(12)),
                  child: Text('Circles', style: AppTextStyles.caption2Regular),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Список боев
            Text('Player\nCombats', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary, height: 1.1)),
            const SizedBox(height: 16),
            
            // Заглушки карточек боев
            _buildCombatCard(),
            _buildCombatCard(),
            _buildCombatCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.caption2Regular),
        Text(value, style: AppTextStyles.textMedium.copyWith(color: AppColors.primary)),
      ],
    );
  }

  Widget _buildCombatCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputLine),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: AppColors.black, radius: 16, child: Icon(Icons.person, size: 16, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('VS', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
          ),
          const CircleAvatar(backgroundColor: AppColors.primary, radius: 16, child: Icon(Icons.person, size: 16, color: Colors.white)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Darrell Steward', style: AppTextStyles.caption2Regular),
                Text('VS', style: AppTextStyles.caption2Regular.copyWith(fontSize: 8)),
                Text('Guy Hawkins', style: AppTextStyles.caption2Regular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}