import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FunnyQuestionPage extends StatefulWidget {
  @override
  _FunnyQuestionPageState createState() => _FunnyQuestionPageState();
}

class _FunnyQuestionPageState extends State<FunnyQuestionPage> {
  String _question = '';
  String _prompt = '';
  bool _isLoading = false;

  // Function to call the Flask API
  Future<void> fetchFunnyQuestion(String prompt) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://127.0.0.1:5000/generate_question'); // Adjust to your Flask server's URL if needed
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _question = data['question'];
      });
    } else {
      setState(() {
        _question = 'Failed to generate question';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Function to generate a random question
  Future<void> generateRandomQuestion() async {
    // Send an empty JSON to get a random question
    await fetchFunnyQuestion('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Funny Question Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text field to input a custom prompt
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter prompt',
                ),
                onChanged: (value) {
                  _prompt = value;
                },
              ),
            ),
            // Button to generate a question from the prompt
            ElevatedButton(
              onPressed: () {
                fetchFunnyQuestion(_prompt);
              },
              child: Text('Generate Question'),
            ),
            SizedBox(height: 20),
            // Button to generate a random question
            ElevatedButton(
              onPressed: generateRandomQuestion,
              child: Text('Generate Random Question'),
            ),
            SizedBox(height: 20),
            // Display loading indicator or the question
            _isLoading
                ? CircularProgressIndicator()
                : Text(
                    _question,
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 20),
            // Button to clear the screen
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _question = '';
                  _prompt = '';
                });
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FunnyQuestionPage(),
  ));
}
