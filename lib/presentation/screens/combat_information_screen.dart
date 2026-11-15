import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера
import 'game_image_screen.dart';
import 'game_circle_screen.dart';

/// Экран с подробной информацией о выбранном бое.
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class CombatInformationScreen extends StatefulWidget {
  final String category; 

  const CombatInformationScreen({super.key, this.category = 'Image'});

  @override
  State<CombatInformationScreen> createState() => _CombatInformationScreenState();
}

class _CombatInformationScreenState extends State<CombatInformationScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('CombatInformationScreen', 'Жизненный цикл', 'Экран Combat Information открыт (категория: ${widget.category})');
  }

  @override
  void dispose() {
    AppLogger.info('CombatInformationScreen', 'Жизненный цикл', 'Экран Combat Information закрыт (dispose)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text('Combat\nInformation', style: AppTextStyles.title3Semibold.copyWith(color: AppColors.primary, height: 1.1)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      Text('NFTs (Evolve 2)', style: AppTextStyles.captionSemibold),
                      Text('\$4000', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlayerAvatar('Guy Hawkins', true),
                      Text('VS', style: AppTextStyles.title2ExtraBold.copyWith(color: AppColors.primary)),
                      _buildPlayerAvatar('Travis Black', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Hi players, here is the quest. I need 6 valid gamers to join me on this quest playing NFTs (Evolve 2) you will be rewarded according to the positions. lets do this. Ready for the challenge? lets really',
              style: AppTextStyles.captionRegular.copyWith(color: AppColors.description),
            ),
            const SizedBox(height: 24),
            Text('Category', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: AppColors.inputBg, borderRadius: BorderRadius.circular(20)),
              child: Text(widget.category, style: AppTextStyles.captionRegular),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('Winning\nPrice', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
                const SizedBox(width: 24),
                Text('\$2000', style: AppTextStyles.textMedium),
                const SizedBox(width: 24),
                Text('\$500', style: AppTextStyles.textMedium),
                const SizedBox(width: 24),
                Text('\$500', style: AppTextStyles.textMedium),
              ],
            ),
            const SizedBox(height: 24),
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
                      const Icon(Icons.timer, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text('TIME INTERVAL', style: AppTextStyles.captionSemibold.copyWith(color: AppColors.primary)),
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
            AppButton(
              text: 'Join Combat!',
              onPressed: () {
                AppLogger.info('CombatInformationScreen', 'Пользовательский ввод', 'Нажата кнопка "Join Combat!"');
                
                if (widget.category == 'Circle') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GameCircleScreen()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GameImageScreen()));
                }
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
        Text(label, style: AppTextStyles.caption2Regular.copyWith(color: AppColors.primary)),
        Text(date, style: AppTextStyles.caption2Regular),
        Text(time, style: AppTextStyles.caption2Regular),
      ],
    );
  }
}