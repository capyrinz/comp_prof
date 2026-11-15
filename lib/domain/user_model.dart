/// Модель пользователя (Domain Entity).
class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  UserModel({required this.id, required this.name, required this.email, required this.token});

  // Преобразование из JSON в модель (Data mapper)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}