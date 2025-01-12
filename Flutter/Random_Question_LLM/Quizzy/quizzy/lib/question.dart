import 'package:flutter/material.dart';
import 'package:quizzy/data/style.dart';
import 'package:quizzy/model.dart';

class QuestionPage extends StatefulWidget {
  static const routeName = '/question';

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String _generatedQuestion = '';
  String _prompt = '';
  final FunnyQuestionModel _model = FunnyQuestionModel();

  void _generateQuestion() async {
    final question = await _model.fetchFunnyQuestion(_prompt);
    setState(() {
      _generatedQuestion = question;
    });
  }

  void _saveQuestion() async {
    await _model.saveFavoriteQuestion(_generatedQuestion);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Question saved to favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Ask a question, get one in return!', style: AppStyles.headline2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your prompt for a question!',
              style: AppStyles.headline2,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'e.g. "What is the capital of France?"',
                hintStyle: AppStyles.bodyText2,
              ),
              onChanged: (value) {
                _prompt = value;
              },
            ),
            ElevatedButton(
              onPressed: _generateQuestion,
              child: Text('Generate Question', style: AppStyles.bodyText3),
            ),
            SizedBox(height: 20),
            Text(
              _generatedQuestion,
              style: AppStyles.bodyText1,
            ),
            SizedBox(height: 20),
            if (_generatedQuestion.isNotEmpty)
              ElevatedButton(
                onPressed: _saveQuestion,
                child: Text('Save to Favorites', style: AppStyles.bodyText3),
              ),
          ],
        ),
      ),
    );
  }
}