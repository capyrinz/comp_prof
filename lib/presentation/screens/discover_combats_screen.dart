import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'combat_information_screen.dart'; // Импорт для перехода на экран боя
import 'player_information_screen.dart';
/// Экран со списком всех игр (Discover Combats).
class DiscoverCombatsScreen extends StatelessWidget {
  const DiscoverCombatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Верхняя часть розовая
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя панель (Шапка)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Discover\nCombats',
                        style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white, height: 1.1),
                      ),
                      const Spacer(),
                      Text('FILTER', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Поиск
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Combat',
                        prefixIcon: Icon(Icons.search, color: AppColors.primary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Белая нижняя часть со списками
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Секция 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trending this week', style: AppTextStyles.captionSemibold),
                          Text('See All', style: AppTextStyles.caption2Regular),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildMockCombatCard(context),
                      const SizedBox(height: 12),
                      _buildMockCombatCard(context),
                      
                      const SizedBox(height: 24),
                      
                      // Секция 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Most Popular Players', style: AppTextStyles.captionSemibold),
                          Text('See All', style: AppTextStyles.caption2Regular),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Заглушки для игроков
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PlayerInformationScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.inputLine),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(backgroundColor: AppColors.black, radius: 16, child: Icon(Icons.person, size: 16, color: Colors.white)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Scott Brown', style: AppTextStyles.captionSemibold),
                                        Text('Earned \$500', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Секция 3
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Latest Combats', style: AppTextStyles.captionSemibold),
                          Text('See All', style: AppTextStyles.caption2Regular),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildMockCombatCard(context),
                      _buildMockCombatCard(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Временная карточка игры (кликабельная)
  Widget _buildMockCombatCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Переход на экран с информацией о бое
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CombatInformationScreen()),
        );
      },
      child: Container(
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
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Date', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10)),
                Text('Mdn, Nov 4 2019', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('Winning Price', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10)),
                Text('\$500', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}