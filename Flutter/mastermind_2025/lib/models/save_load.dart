import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SaveLoad {
  static const String _settingsKey = 'Settings';
  static const String _dataKey = 'Data';
  static const String playersKey = 'Players';
  static const String resultsKey = 'Results';
  static const String themeKey = 'Theme';

  static Map<String, dynamic> createNewPlayer(String name) {
    return {
      'name': name,
      'score': 0,
      'level': 0,
      'games': 0,
      'wins': 0,
      'losses': 0,
    };
  }

  static Future<void> savePlayerData(String playerName, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_dataKey);
    Map<String, dynamic> dataMap = dataString != null ? jsonDecode(dataString) : {};
    dataMap[playerName] = data;
    prefs.setString(_dataKey, jsonEncode(dataMap));
  }

  static Future<Map<String, dynamic>?> loadPlayerData(String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_dataKey);
    if (dataString != null) {
      final dataMap = jsonDecode(dataString);
      return dataMap[playerName];
    }
    return null;
  }

  static Future<bool> saveGameResult(String playerName, bool won, int time, int tries) async {
    try {
      final existingData = await loadData(resultsKey) ?? {'Results': []};
      existingData['Results'].add({
        'player': playerName,
        'won': won,
        'time': time,
        'tries': tries,
        'date': DateTime.now().toIso8601String(),
      });
      return await saveData(resultsKey, existingData);
    } catch (e) {
      print('Error saving game result: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> loadGameResults() async {
    try {
      final data = await loadData(resultsKey);
      return data?['Results']?.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading game results: $e');
      return null;
    }
  }

  static Future<bool> saveData(String key, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String jsonData = jsonEncode(data);
      return await prefs.setString(key, jsonData);
    } catch (e) {
      print('Error saving data: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loadData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonData = prefs.getString(key);
      return jsonData != null ? jsonDecode(jsonData) : null;
    } catch (e) {
      print('Error loading data: $e');
      return null;
    }
  }

  static Future<bool> saveResultsToFile() async {
    try {
      final results = await loadGameResults();
      if (results != null) {
        final file = File('assets/save.json');
        await file.writeAsString(jsonEncode({'Results': results}));
        return true;
      }
      return false;
    } catch (e) {
      print('Error saving results to file: $e');
      return false;
    }
  }

  static Future<void> saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    final settings = {
      'DarkMode': isDarkMode,
    };
    prefs.setString(_settingsKey, jsonEncode(settings));
  }

  static Future<bool?> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsString = prefs.getString(_settingsKey);
    if (settingsString != null) {
      final settings = jsonDecode(settingsString);
      return settings['DarkMode'];
    }
    return null;
  }

  static Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_dataKey);
    if (dataString != null) {
      final dataMap = jsonDecode(dataString);
      dataMap.forEach((key, value) {
        value['Score'] = 0.00;
        value['Time'] = 0.00;
        value['Best_Time'] = 0.00;
        value['Best_Score'] = 0.00;
      });
      prefs.setString(_dataKey, jsonEncode(dataMap));
    }
  }

  // Test usage:
  // static Future<void> testSaveLoad() async {
  //   final newPlayer = createNewPlayer('Player1');
  //   await savePlayerData('Player1', newPlayer);
  //   final loadedPlayer = await loadPlayerData('Player1');
  //   print('Loaded player data: $loadedPlayer');
  // }
}