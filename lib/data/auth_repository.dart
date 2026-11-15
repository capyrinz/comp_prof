import 'package:network_layer/network_layer.dart';
import '../domain/user_model.dart';

/// Репозиторий для работы с авторизацией (связывает UI и Сеть).
class AuthRepository {
  final IApiClient _apiClient;

  AuthRepository(this._apiClient);

  /// Метод авторизации
  Future<UserModel> login(String email, String password) async {
    final response = await _apiClient.post('/login', {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response);
  }
}