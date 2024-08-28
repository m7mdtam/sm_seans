import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: 'authToken');
  }

  Future<int?> getUserId() async {
    String? userIdStr = await _secureStorage.read(key: 'id');
    return userIdStr != null ? int.tryParse(userIdStr) : null;
  }

  Future<String?> getUseremail() async {
    return await _secureStorage.read(key: 'email');
  }
}
