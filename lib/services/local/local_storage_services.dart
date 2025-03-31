import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/app_strings_constants.dart';
import '../../modules/login/model/session_model.dart';

class LocalStorageServices {
  static late final SharedPreferences _preferences;

  ///Initialize Shared Preference before using it,
  ///Must wait for initialization to complete.
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Storage keys

  static const _sessionKey = '${AppStrings.localStorageCode}_session_data';

  //Read Session, default: null
  static SessionModel? get session {
    final data = _preferences.getString(_sessionKey) ?? '';
    if (data.isEmpty) return null;
    return SessionModel.fromJson(json.decode(data));
  }

  ///Write Session
  static set session(SessionModel? value) {
    if (value == null) {
      _preferences.setString(_sessionKey, '');
    } else {
      _preferences.setString(_sessionKey, json.encode(value.toJson()));
    }
  }
}
