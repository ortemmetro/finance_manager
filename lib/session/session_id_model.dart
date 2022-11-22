import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionIdModel {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> writeUserId(String currentUserId) async {
    await _secureStorage.write(
      key: "uid",
      value: currentUserId,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> readUserId(String key) async {
    var readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }
}
