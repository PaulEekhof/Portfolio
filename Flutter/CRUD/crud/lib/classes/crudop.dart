import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CrudOperations {
  final String storageKey;

  CrudOperations(this.storageKey);

  Future<List<dynamic>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(storageKey);
    if (data != null) {
      return json.decode(data);
    } else {
      return [];
    }
  }

  Future<dynamic> getOne(String id) async {
    final items = await getAll();
    return items.firstWhere((item) => item['id'] == id, orElse: () => null);
  }

  Future<void> create(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final items = await getAll();
      
      // Ensure required fields exist
      if (!data.containsKey('id')) {
        throw Exception('Record must have an ID');
      }
      
      // Add the new item
      items.add(data);
      
      // Save back to storage
      await prefs.setString(storageKey, json.encode(items));
    } catch (e) {
      throw Exception('Failed to create record: $e');
    }
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getAll();
    final index = items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      items[index] = data;
      await prefs.setString(storageKey, json.encode(items));
    }
  }

  Future<void> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getAll();
    items.removeWhere((item) => item['id'] == id);
    await prefs.setString(storageKey, json.encode(items));
  }
}