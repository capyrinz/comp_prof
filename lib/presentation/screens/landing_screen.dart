import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'discover_combats_screen.dart';
import 'schedule_game_screen.dart';
import 'statistics_screen.dart';
import 'side_menu.dart';

/// Класс отвечает за отображение главного экрана приложения с навигацией.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('LandingScreen', 'Жизненный цикл', 'Главный экран открыт (initState)');
  }

  @override
  void dispose() {
    AppLogger.info('LandingScreen', 'Жизненный цикл', 'Главный экран закрыт (dispose)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const SideMenu(), 
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primary),
            onPressed: () {
              AppLogger.debug('LandingScreen', 'Пользовательский ввод', 'Открыто боковое меню');
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(backgroundColor: AppColors.black, radius: 12, child: Icon(Icons.person, size: 16, color: Colors.white)),
            const SizedBox(width: 8),
            Text('Stone Stellar', style: AppTextStyles.captionSemibold),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppCard(
              title: "Schedule",
              description: "Easily schedule event/games then find like minded players for battle.",
              icon: Icons.calendar_month,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleGameScreen())),
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Statistics",
              description: "All data from previous and upcoming games can be found here",
              icon: Icons.bar_chart,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StatisticsScreen())),
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Discover Combats",
              description: "Find out what's new and complete challenges and earn cash",
              icon: Icons.explore,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverCombatsScreen())),
            ),
            const SizedBox(height: 16),
            AppCard(
              title: "Message Players",
              description: "Found the profile of a player that interests you? Start a conversation.",
              icon: Icons.chat_bubble_outline,
              onTap: () {},
            ),
            const SizedBox(height: 40), 
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: 2, 
        onTap: (index) {
          AppLogger.debug('LandingScreen', 'Навигация', 'Нажата кнопка нижней панели: $index');
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StatisticsScreen()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverCombatsScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleGameScreen()));
          }
        },
      ),
    );
  }
}