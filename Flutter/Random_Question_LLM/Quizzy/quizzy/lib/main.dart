import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'funnyquestions.dart';
import 'funny_question_page.dart';
import 'home.dart';
import 'favorites.dart';
import 'generate.dart'; // Ensure this file contains the GeneratePage class
import 'question.dart';
import 'model.dart';

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  String _prediction = '';

  // Function to make HTTP request to the backend
  Future<void> fetchPrediction(List<int> inputIdx) async {
    final url = Uri.parse('http://127.0.0.1:5000/predict');  // Backend server URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'input_idx': inputIdx}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _prediction = 'Prediction: ${data['prediction']}';
      });
    } else {
      setState(() {
        _prediction = 'Failed to get prediction';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Model Prediction')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Example input indices
                List<int> inputIdx = [1, 2, 3, 4]; // Replace with actual sequence
                fetchPrediction(inputIdx);
              },
              child: Text('Get Prediction'),
            ),
            SizedBox(height: 20),
            Text(_prediction),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/favorites': (context) => FavoritesPage(),
      '/generate': (context) => GeneratePage(),
      '/question': (context) => QuestionPage(
      
      ),
      '/prediction': (context) => PredictionPage(),
    },
  ));
}
