import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Виджет бокового меню (Side Menu), который открывается свайпом или по клику на гамбургер.
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
            // Кнопка закрытия (Крестик)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.primary),
                onPressed: () {
                  Navigator.pop(context); // Закрываем меню
                },
              ),
            ),
            
            // Профиль пользователя
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.inputLine,
                    child: Icon(Icons.person, color: AppColors.white),
                  ),
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

            // Пункты меню
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(context, Icons.person_outline, 'My Profile'),
                  _buildMenuItem(context, Icons.calendar_today_outlined, 'Schedule'),
                  _buildMenuItem(context, Icons.bar_chart, 'Statistics'),
                  _buildMenuItem(context, Icons.location_on_outlined, 'Discover Combat'),
                  _buildMenuItem(context, Icons.chat_bubble_outline, 'Chat'),
                  _buildMenuItem(context, Icons.language, 'Change Language'),
                  _buildMenuItem(context, Icons.color_lens_outlined, 'Change App Skin'),
                ],
              ),
            ),

            // Кнопка выхода
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text('Logout', style: AppTextStyles.textRegular.copyWith(color: AppColors.error)),
              onTap: () {
                // TODO: Логика выхода
                debugPrint("[SideMenu]: Нажата кнопка Logout");
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Вспомогательный метод для создания пунктов меню (Принцип DRY)
  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyles.textRegular),
      onTap: () {
        debugPrint("[SideMenu]: Переход в раздел $title");
        Navigator.pop(context); // Закрываем меню при выборе
      },
    );
  }
}