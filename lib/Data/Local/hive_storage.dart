import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../constants/string.dart';

class LocalStorage {
  static late Box _authBox;
  // init
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(AppStrings.authBox);
    _authBox = Hive.box(AppStrings.authBox);
  }

  // auth
  static Future<void> setUser(String id, String? token) async {
    await setUserId(id);
    await setAccessToken(token);
  }

  static Future<void> setAccessToken(String? token) async {
    await _authBox.put(AppStrings.accessToken, token);
  }

  static String? get getAccessToken {
    return _authBox.get(AppStrings.accessToken);
  }

  static Future<void> setUserId(String? id) async {
    await _authBox.put(AppStrings.userId, id);
  }

  static String? get getUserId {
    return _authBox.get(AppStrings.userId);
  }

  static Future<void> clearAuth() async {
    await _authBox.clear();
  }
}