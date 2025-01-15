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

  Future<void> fetchFunnyQuestion(String prompt) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://127.0.0.1:5000/generate_question');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Funny Question Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            ElevatedButton(
              onPressed: () {
                fetchFunnyQuestion(_prompt);
              },
              child: Text('Generate Question'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Text(
                    _question,
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 20),
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
