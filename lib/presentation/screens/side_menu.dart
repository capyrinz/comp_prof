import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'player_information_screen.dart';
import 'schedule_game_screen.dart';
import 'statistics_screen.dart';
import 'discover_combats_screen.dart';
import 'splash_screen.dart'; 
import '../../data/session_manager.dart';

/// Класс отвечает за отображение бокового меню и навигацию по приложению.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(radius: 24, backgroundColor: AppColors.inputLine, child: Icon(Icons.person, color: AppColors.white)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Stone Stellar', style: AppTextStyles.textMedium),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text('Gold Player', style: AppTextStyles.caption2Regular),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.cardLine),
            const SizedBox(height: 8),
            
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(context, Icons.person_outline, 'My Profile', 
                      () => const PlayerInformationScreen(isCurrentUser: true)),
                  _buildMenuItem(context, Icons.calendar_today_outlined, 'Schedule', 
                      () => const ScheduleGameScreen()),
                  _buildMenuItem(context, Icons.bar_chart, 'Statistics', 
                      () => const StatisticsScreen()),
                  _buildMenuItem(context, Icons.location_on_outlined, 'Discover Combat', 
                      () => const DiscoverCombatsScreen()),
                  _buildMenuItem(context, Icons.chat_bubble_outline, 'Chat', null),
                  _buildMenuItem(context, Icons.language, 'Change Language', null),
                  _buildMenuItem(context, Icons.color_lens_outlined, 'Change App Skin', null),
                ],
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text('Logout', style: AppTextStyles.textRegular.copyWith(color: AppColors.error)),
              onTap: () async {
                // ЛОГ НАЖАТИЯ
                AppLogger.info('SideMenu', 'Пользовательский ввод', 'Нажата кнопка "Logout"');
                
                await SessionManager.logout(); // Очищаем сессию
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => const SplashScreen()), 
                    (route) => false
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget Function()? screenBuilder) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyles.textRegular),
      onTap: () {
        Navigator.pop(context); // Сначала закрываем меню
        if (screenBuilder != null) {
          // ЛОГ НАВИГАЦИИ
          AppLogger.debug('SideMenu', 'Навигация', 'Переход на экран: $title');
          Navigator.push(context, MaterialPageRoute(builder: (context) => screenBuilder()));
        } else {
          // ЛОГ ЗАГЛУШКИ
          AppLogger.debug('SideMenu', 'Навигация', 'Раздел "$title" находится в разработке');
        }
      },
    );
  }
}