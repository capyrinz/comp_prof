import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'side_menu.dart';
import 'schedule_game_screen.dart';
import 'discover_combats_screen.dart';
import 'statistics_screen.dart';

/// Главный экран приложения (Landing Screen).
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // 1. Боковое меню
      drawer: const SideMenu(),

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primary),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text('Stone Stellar', style: AppTextStyles.captionSemibold),
        centerTitle: true,
      ),

      // 2. Основной контент с карточками
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppCard(
              title: "Schedule",
              description: "Easily schedule event/games then find like minded players for battle.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduleGameScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Statistics",
              description: "All data from previous and upcoming games can be found here.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatisticsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Discover Combats",
              description:
                  "Find out what's new and complete challenges and earn coins.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiscoverCombatsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Message Players",
              description: "Found the profile of a player that interests you? Start a conversation.",
              onTap: () {},
            ),
            // Добавляем отступ снизу, чтобы нижняя панель не перекрывала карточки
            const SizedBox(height: 40),
          ],
        ),
      ),

      // 3. ТУТ ДОЛЖНА БЫТЬ НАША РОЗОВАЯ ПАНЕЛЬ
      bottomNavigationBar: AppBottomBar(
        currentIndex: 2, // 2 - это центральная кнопка
        onTap: (index) {
          debugPrint("Нажата кнопка $index");
        },
      ),
    );
  }
}
