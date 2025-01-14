// This is the actual game screen for the game MasterMind
// This screen has
// - a list with a row of round colored buttons
// And this functionality
// - When the user taps a button, the app will check if the button is the correct color for the current round and the button will change color.
// - If the sequence of colored buttons is correct, the app will increment the score and move to the next round.
// - The user has 10 tries to get the sequence correct. If the user fails, the game will end. And the user will get no points.
// - The user can pause the game and resume it later.
// - The user can save the game and load it later.
// - The user can view the game instructions.
// - The user can select the difficulty level of the game.
// - The user can go back to the Options screen.

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mastermind_2025/models/save_load.dart';

class GameScreen extends StatefulWidget {
  static const String id = 'old_game_Screen';

  const GameScreen({super.key});
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<Color> _sequence;
  final List<Color> _availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  int _currentRound = 0;
  int _score = 0;
  int _attempts = 10;
  bool _gameOver = false;
  String _difficulty = 'Easy';

  @override
  void initState() {
    super.initState();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    _difficulty = args?['difficulty'] ?? 'Easy';
    _generateSequence();
  }

  void _generateSequence() {
    final random = Random();
    _sequence = List.generate(4, (_) => _availableColors[random.nextInt(6)]);
  }

  void _checkColor(int index, Color selectedColor) {
    if (_sequence[_currentRound] == selectedColor) {
      setState(() {
        _currentRound++;
        if (_currentRound >= _sequence.length) {
          _score++;
          _currentRound = 0;
          _generateSequence();
        }
      });
    } else {
      setState(() {
        _attempts--;
        if (_attempts <= 0) {
          _gameOver = true;
        }
      });
    }
  }

  void _pauseGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Paused'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Resume'),
            ),
          ],
        );
      },
    );
  }

  void _saveGame() async {
    final gameState = {
      'sequence': _sequence.map((color) => color.value).toList(),
      'currentRound': _currentRound,
      'score': _score,
      'attempts': _attempts,
      'difficulty': _difficulty,
    };
    await SaveLoad.saveData('gameState', gameState);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Game saved!')));
  }

  void _loadGame() async {
    final gameState = await SaveLoad.loadData('gameState');
    if (gameState != null) {
      setState(() {
        _sequence = (gameState['sequence'] as List).map((value) => Color(value)).toList();
        _currentRound = gameState['currentRound'];
        _score = gameState['score'];
        _attempts = gameState['attempts'];
        _difficulty = gameState['difficulty'];
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Game loaded!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No saved game found!')));
    }
  }

  void _restartGame() {
    setState(() {
      _currentRound = 0;
      _score = 0;
      _attempts = 10;
      _gameOver = false;
      _generateSequence();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final difficulty = args?['difficulty'] ?? 'Easy';

    return Scaffold(
      appBar: AppBar(
        title: Text('Mastermind Game - $difficulty'),
        actions: [
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: _pauseGame,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveGame,
          ),
          IconButton(
            icon: Icon(Icons.folder_open),
            onPressed: _loadGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _gameOver
                  ? 'Game Over! Final Score: $_score'
                  : 'Score: $_score | Attempts Left: $_attempts',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (!_gameOver)
              Wrap(
                spacing: 10,
                children: _availableColors.map((color) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      fixedSize: Size(50, 50),
                    ),
                    onPressed: () {
                      _checkColor(_currentRound, color);
                    },
                    child: SizedBox(),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            if (_gameOver)
              ElevatedButton(
                onPressed: _restartGame,
                child: Text('Restart Game'),
              ),
          ],
        ),
      ),
    );
  }
}
