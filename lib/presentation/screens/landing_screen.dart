import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'side_menu.dart';
import 'schedule_game_screen.dart';

/// Главный экран приложения (Landing Screen).
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // 1. ДОБАВЛЯЕМ БОКОВОЕ МЕНЮ СЮДА
      drawer: const SideMenu(),

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,

        // 2. ИСПОЛЬЗУЕМ BUILDER ДЛЯ ОТКРЫТИЯ МЕНЮ
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primary),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Открывает SideMenu
            },
          ),
        ),
        title: Text('Stone Stellar', style: AppTextStyles.captionSemibold),
        centerTitle: true,
      ),

      // ... дальше идет твой body с карточками, его оставляем без изменений ...

      // Основной контент
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Карточка 1
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

            // Карточка 2
            AppCard(
              title: "Statistics",
              description: "All data from previous and upcoming games can be found here.",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Карточка 3
            AppCard(
              title: "Discover Combats",
              description:
                  "Find out what's new and complete challenges and earn coins.",
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Карточка 4
            AppCard(
              title: "Message Players",
              description: "Found the profile of a player that interests you? Start a conversation.",
              onTap: () {},
            ),
          ],
        ),
      ),

      // Нижнее меню (Bottom Bar) - пока делаем заглушку
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.description,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Center',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
