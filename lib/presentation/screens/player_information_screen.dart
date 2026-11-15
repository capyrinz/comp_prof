import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:network_layer/network_layer.dart'; // Импорт логгера

/// Экран с информацией об игроке (Player Information).
/// 
/// Дата создания: 15-11-2026
/// Автор создания: [Твой номер]
class PlayerInformationScreen extends StatefulWidget {
  final bool isCurrentUser; 

  const PlayerInformationScreen({super.key, this.isCurrentUser = false});

  @override
  State<PlayerInformationScreen> createState() => _PlayerInformationScreenState();
}

class _PlayerInformationScreenState extends State<PlayerInformationScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    AppLogger.info('PlayerInformationScreen', 'Жизненный цикл', 'Экран профиля открыт (initState)');
  }

  @override
  void dispose() {
    AppLogger.info('PlayerInformationScreen', 'Жизненный цикл', 'Экран профиля закрыт (dispose)');
    super.dispose();
  }

  void _showImageSourceDialog() {
    AppLogger.debug('PlayerInformationScreen', 'Пользовательский ввод', 'Открыто меню смены аватара');
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primary),
                title: const Text('Выбрать из галереи'),
                onTap: () async {
                  AppLogger.info('PlayerInformationScreen', 'Пользовательский ввод', 'Выбрана галерея для смены фото');
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    AppLogger.debug('PlayerInformationScreen', 'Фото', 'Фото из галереи успешно загружено');
                    setState(() { _imageFile = File(pickedFile.path); });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                title: const Text('Сделать фото'),
                onTap: () async {
                  AppLogger.info('PlayerInformationScreen', 'Пользовательский ввод', 'Выбрана камера для смены фото');
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    AppLogger.debug('PlayerInformationScreen', 'Фото', 'Фото с камеры успешно получено');
                    setState(() { _imageFile = File(pickedFile.path); });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: widget.isCurrentUser ? _showImageSourceDialog : null,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.black,
                          backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                          child: _imageFile == null ? const Icon(Icons.person, size: 40, color: AppColors.white) : null,
                        ),
                        if (widget.isCurrentUser)
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt, size: 16, color: AppColors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(widget.isCurrentUser ? 'Stone Stellar' : 'Scott Brown', style: AppTextStyles.title3Semibold),
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
            // ... (Остальной код со списком боев остается без изменений, он у тебя уже есть) ...
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
}