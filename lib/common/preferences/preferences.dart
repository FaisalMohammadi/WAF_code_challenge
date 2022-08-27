import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/models/book_model.dart';

/// provides functionality to load and save preferences
class Preferences {


  static final Preferences _instance = Preferences._ctor();

  /// holds the singleton instance of the shared-preferences
  static late SharedPreferences _preferences;

  factory Preferences() {
    return _instance;
  }

  Preferences._ctor();

  /// initializes the shared preferences
  static initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// clears all the stored key value pairs in shared preferences
  static clear() {
    return _preferences.clear();
  }

  /// removes a specific value from shared preferences
  static removeValue(String key) {
    return _preferences.remove(key);
  }

  /// ensures and returns the singleton instance of the shared-preferences
  /* static Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences!;
  } */

  /// sets the list of string from preference by given key to given listValue
  static setStringList(String key, List<String> list) {
    _preferences.setStringList(key, list);
  }

  /// gets the list of string from preference by given key
  static List<String> getStringList(String key) {
    return _preferences.getStringList(key) ?? [];
  }

  /// gets the string preference by given key
  static String? getString(String key) {
    return _preferences.getString(key);
  }

  /// sets the string preference by given key to given value
  static void setString(String key, String value) {
    _preferences.setString(key, value);
  }

  /// gets the string preference by given key
  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  /// sets the string preference by given key to given value
  static void setBool(String key, bool? value) {
    if (value != null) {
      _preferences.setBool(key, value);
    } else {
      _preferences.remove(key);
    }
  }

  /// gets the string preference by given key
  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  /// sets the string preference by given key to given value
  static void setInt(String key, int value) {
    _preferences.setInt(key, value);
  }

  /// loads the string for given key and derserializes it to given T
  static  getbookModel<T>(String key) {
    // check if key exists
    if (!_preferences.containsKey(key)) {
      return null;
    }

    try {
      // deserialize value from preferences
      String? value = _preferences.getString(key);

      /* var serializer = serializers.serializerForType(T) as Serializer<T>;
      Object? result = serializers.serializeWith<T>(serializer, value); */
      //print("22222 is ${value}");

      List<dynamic> result =  jsonDecode(value!);
      return result;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// serializes given client-api-model and sets it as string preference
  static void setBookModel<T>(String key, List<T>? value) {
    
    // check value
    /* if (value == null) {
      (await preferences).remove(key);
      return;
    } */

    try {
      // serialize value and set in preferences
      /* var serializer = serializers.serializerForType(T) as Serializer<T>;
      Object? result = serializers.serializeWith<T>(serializer, value); */
      if (value == null) {
        _preferences.remove(key);
      } else {
        
        String encoded = jsonEncode(value);
          _preferences.setString(key, encoded).then((value2) => print("shared value is ${value2}"));
      }
    } catch (error) {
      throw error; // used for better debugging exceptions that occur here
    }
  }
}
