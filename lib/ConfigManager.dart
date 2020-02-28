import 'package:woodemi_service/model.dart';

import 'LocalPreference.dart';

final configManager = ConfigManager._();

class ConfigManager {
  ConfigManager._();

  Future<ClientAgent> getClientAgent() async {
    var json = await localPreference.getJSON('clientAgent');
    return json != null ? ClientAgent.fromJson(json) : null;
  }

  Future<void> setClientAgent(ClientAgent value) async {
    await localPreference.setJSON('clientAgent', value.toJson());
  }

  Future<Environment> getEnvironment() async {
    var json = await localPreference.getJSON('environment');
    return json != null ? Environment.fromJson(json) : null;
  }

  Future<void> setEnvironment(Environment value) async {
    await localPreference.setJSON('environment', value.toJson());
  }
}
