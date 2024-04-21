import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? "Empty";
    print("SecureData ${value}");
    return value;
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
