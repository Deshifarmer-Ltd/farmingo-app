import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Private constructor
  SharedPrefs._privateConstructor();

  // Singleton instance
  static final SharedPrefs _instance = SharedPrefs._privateConstructor();

  // Factory constructor to return the same instance
  factory SharedPrefs() => _instance;

  // SharedPreferences instance
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Save a int value
  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }
  // Get a int value
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Get a boolean value
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all values
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
