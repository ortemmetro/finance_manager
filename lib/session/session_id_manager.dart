import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionIdManager {
  static final SessionIdManager instance = SessionIdManager._();
  SessionIdManager._();

  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> writeUserKey(int userKey) async {
    await _secureStorage.write(
      key: "ukey",
      value: userKey.toString(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<int?> readUserKey() async {
    final readData =
        await _secureStorage.read(key: "ukey", aOptions: _getAndroidOptions());
    return int.parse(readData!);
  }

  Future<void> writeUserId(String currentUserId) async {
    await _secureStorage.write(
      key: "uid",
      value: currentUserId,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> readUserId() async {
    final readData =
        await _secureStorage.read(key: "uid", aOptions: _getAndroidOptions());
    return readData;
  }
}
