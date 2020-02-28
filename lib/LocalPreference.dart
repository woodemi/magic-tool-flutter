import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final localPreference = LocalPreference._();

class LocalPreference {
  LocalPreference._();

  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  Future<String> get(String key) async =>
      (await sharedPreferences).getString(key);

  Future<void> set(String key, String value) async =>
      (await sharedPreferences).setString(key, value);

  Future<Map> getJSON(String key) async {
    var s = await sharedPreferences;
    return s.containsKey(key) ? jsonDecode(s.get(key)) : null;
  }

  Future<void> setJSON(String key, Map value) async {
    var s = await sharedPreferences;
    return s.setString(key, jsonEncode(value));
  }
}
