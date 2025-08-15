

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/auth/domain/domain.dart';

class SecureStorageHandler {
  static final _storage = FlutterSecureStorage();
  static final UserRepository _userRepository = UserRepositoryImpl();

  static Future<void> refreshToken() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');

    if (username != null && password != null) {
      final newToken = await _userRepository.login(username, password);
      await saveToken(newToken);
    }
  }

  static Future<void> saveToken(String token) async {
    final expiryDate = DateTime.now().add(const Duration(minutes: 30));
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'token_expiration', value: expiryDate.toIso8601String());
  }

  static Future<void> saveUser(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  static Future<String?> getToken() async {

    final token = await _storage.read(key: 'token');
    final expiryDateStr = await _storage.read(key: 'token_expiration');

    if (token != null && expiryDateStr != null) {

      final expiryDate = DateTime.parse(expiryDateStr);

      if (expiryDate.isAfter(DateTime.now())) {
        return token; // Token is valid
      } 
    }
    return null; // No valid token found
  }

  static Future<Map<String, String?>?> getUser() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');
    final token = await getToken();

    if (username != null && password != null && token != null) {
      return {
        'username': username,
        'password': password,
        'token': token
      };
    }

    return null; // No hay usuario guardado
  }

  static Future<void> deleteUser() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'token_expiration');
  }

  static Future<bool> hasTokenExpired() async {
  final expiryDateStr = await _storage.read(key: 'token_expiration');

  if (expiryDateStr == null) {
    return true; 
  }

  final expiryDate = DateTime.parse(expiryDateStr);
  return DateTime.now().isAfter(expiryDate); 
}



}

