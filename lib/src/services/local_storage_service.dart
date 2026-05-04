import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  final _storage = const FlutterSecureStorage();

  // Guarda quem é o usuário logado no momento para abrir o app direto depois
  static const _keyCurrentUid = 'current_uid'; 

  Future<void> saveUserData({required String uid, required String role, required String name}) async {
    await _storage.write(key: '${uid}_role', value: role);
    await _storage.write(key: '${uid}_name', value: name);
    await _storage.write(key: _keyCurrentUid, value: uid);
  }

  Future<String?> getRole(String uid) async {
    return await _storage.read(key: '${uid}_role');
  }

  Future<String?> getCurrentUid() async {
    return await _storage.read(key: _keyCurrentUid);
  }

  Future<String?> getName(String uid) async {
    return await _storage.read(key: '${uid}_name');
  }

  Future<void> clearCurrentUser() async {
    await _storage.delete(key: _keyCurrentUid);
  }
}