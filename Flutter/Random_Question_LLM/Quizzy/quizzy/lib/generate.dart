import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizzy/model.dart';
import 'package:quizzy/data/style.dart';

class GeneratePage extends StatefulWidget {
  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  String _generatedQuestion = '';
  bool _isLoading = false;
  String? _error;
  final FunnyQuestionModel _model = FunnyQuestionModel();

  void _generateQuestion() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

  List<String> random_input_list = [
  "What's the funniest thing you've heard this week?",
  "If animals could talk, which one would be the funniest?",
  "Why did the chicken cross the playground?",
  "What do you call a bear with no teeth?",
  "What's your favorite thing to do when you're bored?",
  "How many tickles does it take to make an octopus laugh?",
  "What's the weirdest thing you've ever eaten?",
  "If your pet could talk, what do you think it would say?",
  "What’s the funniest word in the English language?",
  "How do you organize a space party?",
  "What would you do if you found a unicorn in your backyard?",
  "Why can't you trust an atom?",
  "What do you call a fish who practices medicine?",
  "Why did the bicycle fall over?",
  "What would happen if pigs could fly?",
  "How do you catch a squirrel?",
  "If aliens visited Earth, what do you think they would find most confusing?",
  "What's the best way to make a lemon laugh?",
  "Why don't skeletons fight each other?",
  "What would happen if humans could breathe underwater?",
  "What would a robot do if it became the president of the world?",
  "How do you make a tissue dance?",
  "If you could time travel, what era would you go to?",
  "Why did the computer go to the doctor?",
  "What happens if you tickle a dinosaur?",
  "What do you get when you cross a snowman and a vampire?",
  "What do you think dogs dream about?",
  "What would you do if your phone became self-aware?",
  "Why don't we ever see hippos hiding in trees?",
  "If your shoes could talk, what would they say about you?",
  "What would happen if we could teleport?",
  "What do you get when you cross a vampire and a snowman?",
  "What do you think clouds taste like?",
  "Why do cows wear bells?",
  "What would it be like to live inside a pineapple?",
  "How do you convince a cat to play fetch?",
  "If you could be any kind of sandwich, what kind would you be?",
  "What’s your favorite joke to tell?",
  "What would happen if everyone suddenly turned invisible?",
  "What do you think would happen if cars could talk?",
  "Why are ghosts bad at lying?",
  "What do you think a robot’s favorite song is?",
  "What would happen if trees could walk?",
  "What do you call a lazy kangaroo?",
  "Why do birds fly south for the winter?",
  "What’s the funniest thing that could happen at a wedding?",
  "What do you think a pirate’s favorite color is?",
  "If your life was a sitcom, what would be the theme song?",
  "What would you do if you found out your socks were secretly in a relationship?",
  "What would happen if you put a balloon in the freezer?"
];


    try {
      final question = await _model.fetchFunnyQuestion(random_input_list[Random().nextInt(random_input_list.length)]);
      setState(() {
        _generatedQuestion = question;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to generate question. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _saveQuestion() async {
    if (_generatedQuestion.isEmpty) return;

    try {
      await _model.saveFavoriteQuestion(_generatedQuestion);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question saved to favorites')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save question')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Generate Random Question', style: AppStyles.headline2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _generateQuestion,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Generate Question'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: AppStyles.bodyText2.copyWith(color: Colors.red),
              )
            else if (_generatedQuestion.isNotEmpty)
              Text(
                _generatedQuestion,
                style: AppStyles.bodyText3,
              ),
            if (_generatedQuestion.isNotEmpty) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveQuestion,
                child: const Text('Save to Favorites'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}