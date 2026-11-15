import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'combat_information_screen.dart';
import 'player_information_screen.dart';
import 'schedule_game_screen.dart';
import 'statistics_screen.dart';

/// Экран со списком всех игр (Discover Combats).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class DiscoverCombatsScreen extends StatefulWidget {
  const DiscoverCombatsScreen({super.key});

  @override
  State<DiscoverCombatsScreen> createState() => _DiscoverCombatsScreenState();
}

class _DiscoverCombatsScreenState extends State<DiscoverCombatsScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('DiscoverCombatsScreen', 'Жизненный цикл', 'Экран Discover Combats открыт (initState)');
  }

  @override
  void dispose() {
    AppLogger.info('DiscoverCombatsScreen', 'Жизненный цикл', 'Экран Discover Combats закрыт (dispose)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Шапка (Розовая)
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
                      Text('Discover\nCombats', style: AppTextStyles.title2Semibold.copyWith(color: AppColors.white, height: 1.1)),
                      const Spacer(),
                      Text('FILTER', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(30)),
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
            
            // Белая часть
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
                      _buildSectionHeader('Trending this week'),
                      _buildGameCard(context, 'Darrell Steward', 'Guy Hawkins', 'Image', '13:30 AM'),
                      _buildGameCard(context, 'Darrell Steward', 'Guy Hawkins', 'Circle', '13:30 AM'),
                      
                      const SizedBox(height: 24),
                      _buildSectionHeader('Most Popular Players'),
                      GestureDetector(
                        onTap: () {
                          AppLogger.debug('DiscoverCombatsScreen', 'Навигация', 'Открыт профиль игрока Scott Brown');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerInformationScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.inputLine),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(backgroundColor: AppColors.black, radius: 16, child: Icon(Icons.person, size: 16, color: Colors.white)),
                              const SizedBox(width: 12),
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

                      const SizedBox(height: 24),
                      _buildSectionHeader('Latest Combats'),
                      _buildGameCard(context, 'Darrell Steward', 'Guy Hawkins', 'Image', '13:30 AM'),
                      _buildGameCard(context, 'Darrell Steward', 'Guy Hawkins', 'Circle', '13:30 AM'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Нижняя панель
      bottomNavigationBar: AppBottomBar(
        currentIndex: 1, 
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StatisticsScreen()));
          if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScheduleGameScreen()));
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.captionSemibold),
          Text('See All', style: AppTextStyles.caption2Regular),
        ],
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, String player1, String player2, String category, String time) {
    return GestureDetector(
      onTap: () {
        AppLogger.debug('DiscoverCombatsScreen', 'Навигация', 'Выбрана игра категории: $category');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CombatInformationScreen(category: category)),
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
                  Text(player1, style: AppTextStyles.caption2Regular, overflow: TextOverflow.ellipsis),
                  Text('VS', style: AppTextStyles.caption2Regular.copyWith(fontSize: 8)),
                  Text(player2, style: AppTextStyles.caption2Regular, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Date', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, color: AppColors.description)),
                Text(time, style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('Winning Price', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, color: AppColors.description)),
                Text('\$500', style: AppTextStyles.caption2Regular.copyWith(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}