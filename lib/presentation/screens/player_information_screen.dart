import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui_kit.dart';

/// Экран с информацией об игроке (Player Information).
class PlayerInformationScreen extends StatefulWidget {
  const PlayerInformationScreen({super.key});

  @override
  State<PlayerInformationScreen> createState() => _PlayerInformationScreenState();
}

class _PlayerInformationScreenState extends State<PlayerInformationScreen> {
  // Переменная для хранения выбранного фото
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  /// Метод для показа выбора (Камера или Галерея)
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primary),
                title: const Text('Выбрать из галереи'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() { _imageFile = File(pickedFile.path); });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                title: const Text('Сделать фото'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
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
            // Карточка профиля
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // ФОТО ПРОФИЛЯ (Кликабельное)
                  GestureDetector(
                    onTap: _showImageSourceDialog, // Вызов выбора фото
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.black,
                          // Если фото есть, показываем его. Если нет - иконку
                          backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                          child: _imageFile == null 
                              ? const Icon(Icons.person, size: 40, color: AppColors.white) 
                              : null,
                        ),
                        // Маленькая иконка камеры поверх аватара
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, size: 16, color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Scott Brown', style: AppTextStyles.title3Semibold),
                  const SizedBox(height: 4),
                  Text('LvL 03', style: AppTextStyles.caption2Regular),
                  // ... (Остальной код профиля остается без изменений: Earned, Played, медали) ...
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('Earned', '\$500'),
                      _buildStat('Played', '\$500'),
                    ],
                  ),
                ],
              ),
            ),
            // ... (Остальной код со списком боев) ...
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