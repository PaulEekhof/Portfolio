import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FunnyQuestionModel {
  // Base URL for the Flask server
  final String baseUrl = 'http://127.0.0.1:5000';

  Future<String> fetchFunnyQuestion(String prompt) async {
    try {
      final url = Uri.parse('$baseUrl/generate_question');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'prompt': prompt.isNotEmpty ? prompt : 'random'
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timed out'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['question'];
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error generating question: $e');
      throw Exception('Failed to generate question');
    }
  }

  Future<void> saveFavoriteQuestion(String question) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorite_questions.json');
      List<String> questions = [];

      if (await file.exists()) {
        final contents = await file.readAsString();
        questions = List<String>.from(json.decode(contents));
      }

      questions.add(question);
      await file.writeAsString(json.encode(questions));
    } catch (e) {
      print('Error saving favorite question: $e');
      throw Exception('Failed to save favorite question');
    }
  }

  Future<List<String>> fetchFavoriteQuestions() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorite_questions.json');
      
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      return List<String>.from(json.decode(contents));
    } catch (e) {
      print('Error fetching favorite questions: $e');
      return [];
    }
  }
}
