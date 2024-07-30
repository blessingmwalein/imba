import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utilities/constants.dart';

class SecureStorageManager {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  void setToken({required String token}) async {
    await _storage.write(key: ACCESS_TOKEN, value: token);
  }

  Future<String> getToken() async {
    String token = await _storage.read(key: ACCESS_TOKEN) ?? '';
    return token;
  }

  void setIsAcceptedTerms({required String isAccepted}) async {
    await _storage.write(key: IS_ACCEPTED_TERMS, value: isAccepted);
  }

  Future<String> isAcceptedTerms() async {
    String isAccepted = await _storage.read(key: IS_ACCEPTED_TERMS) ?? '';
    return isAccepted;
  }

  void logout() async {
    await _storage.deleteAll();
  }
}
