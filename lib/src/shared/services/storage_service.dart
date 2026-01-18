import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyIsFirstTimeOpen = 'isFirstTimeOpen';
  static const String _keyAccessToken = 'accessToken';
  static const String _keyRefreshToken = 'refreshToken';
  static const String _keyUserData = 'userData';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Initialize StorageService
  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // Check if it's the first time opening the app
  bool get isFirstTimeOpen {
    return _prefs.getBool(_keyIsFirstTimeOpen) ?? true;
  }

  // Set first time open flag
  Future<bool> setIsFirstTimeOpen(bool value) async {
    return await _prefs.setBool(_keyIsFirstTimeOpen, value);
  }

  // ========== Authentication Storage ==========

  // Get access token
  String? get accessToken {
    return _prefs.getString(_keyAccessToken);
  }

  // Set access token
  Future<bool> setAccessToken(String token) async {
    return await _prefs.setString(_keyAccessToken, token);
  }

  // Get refresh token
  String? get refreshToken {
    return _prefs.getString(_keyRefreshToken);
  }

  // Set refresh token
  Future<bool> setRefreshToken(String token) async {
    return await _prefs.setString(_keyRefreshToken, token);
  }

  // Get user data
  Map<String, dynamic>? get userData {
    final userDataString = _prefs.getString(_keyUserData);
    if (userDataString == null) return null;
    try {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Set user data
  Future<bool> setUserData(Map<String, dynamic> userData) async {
    try {
      final userDataString = jsonEncode(userData);
      return await _prefs.setString(_keyUserData, userDataString);
    } catch (e) {
      return false;
    }
  }

  // Check if user is logged in
  bool get isLoggedIn {
    return accessToken != null && accessToken!.isNotEmpty;
  }

  // Clear authentication data
  Future<bool> clearAuthData() async {
    try {
      await _prefs.remove(_keyAccessToken);
      await _prefs.remove(_keyRefreshToken);
      await _prefs.remove(_keyUserData);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear all stored data
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}


