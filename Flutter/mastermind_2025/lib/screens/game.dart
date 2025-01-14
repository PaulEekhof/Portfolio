import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';
import 'package:mastermind_2025/models/save_load.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class GameScreen extends StatefulWidget {
  static const String id = 'game_Screen';
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _difficulty = 'Easy';
  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];

  final List<Color> _availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  List<Color> _targetSequence = [];
  List<List<Color>> _gameBoard = [];
  List<bool> _correctGuesses = [];
  int _maxTries = 10;
  int _currentRow = 0;
  bool _gameOver = false;
  bool _gameWon = false;

  final Stopwatch _stopwatch = Stopwatch();
  int _sequenceLength = 6;

  String _playerName = 'Player1';

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final random = Random();
    _targetSequence = List.generate(
      _sequenceLength,
      (_) => _availableColors[random.nextInt(_availableColors.length)],
    );

    _gameBoard = List.generate(
        _maxTries, (_) => List.filled(_sequenceLength, Colors.white));
    _correctGuesses = List.filled(_sequenceLength, false);
    _currentRow = 0;
    _gameOver = false;
    _gameWon = false;
    _stopwatch.reset();
    _stopwatch.stop();
  }

  void _startGame() async {
    final name = await _askForPlayerName();
    if (name != null && name.isNotEmpty) {
      setState(() {
        _playerName = name;
        _initializeGame();
        _stopwatch.start();
      });
    }
  }

  Future<String?> _askForPlayerName() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String playerName = '';
        return AlertDialog(
          title: const Text('Enter Player Name'),
          content: TextField(
            onChanged: (value) {
              playerName = value;
            },
            decoration: const InputDecoration(hintText: "Player Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(playerName);
              },
            ),
          ],
        );
      },
    );
  }

  void _updateCell(int colIndex) {
    if (_gameOver || _currentRow >= _maxTries || _correctGuesses[colIndex]) {
      return;
    }

    setState(() {
      int currentColorIndex =
          _availableColors.indexOf(_gameBoard[_currentRow][colIndex]);
      _gameBoard[_currentRow][colIndex] =
          _availableColors[(currentColorIndex + 1) % _availableColors.length];
    });
  }

  void _submitRow() async {
    if (_gameOver) return;

    final currentGuess = _gameBoard[_currentRow];
    if (currentGuess.contains(Colors.white)) {
      _showMessage('Please fill all balls in the row before checking!');
      return;
    }

    for (int i = 0; i < _sequenceLength; i++) {
      if (currentGuess[i] == _targetSequence[i]) {
        _correctGuesses[i] = true;
      }
    }

    if (listEquals(currentGuess, _targetSequence)) {
      setState(() {
        _gameWon = true;
        _gameOver = true;
        _stopwatch.stop();
      });
      await SaveLoad.saveGameResult(_playerName, true, _stopwatch.elapsed.inSeconds, _currentRow + 1);
      await SaveLoad.saveResultsToFile();
      _showMessage(
          'You Win! 🎉 Time: ${_stopwatch.elapsed.inSeconds}s, Tries: ${_currentRow + 1}');
    } else if (_currentRow == _maxTries - 1) {
      setState(() {
        _gameOver = true;
        _stopwatch.stop();
      });
      await SaveLoad.saveGameResult(_playerName, false, _stopwatch.elapsed.inSeconds, _currentRow + 1);
      await SaveLoad.saveResultsToFile();
      _showMessage(
          'Game Over! The correct sequence was ${_targetSequence.join(", ")}');
    } else {
      setState(() {
        _currentRow++;
        for (int i = 0; i < _sequenceLength; i++) {
          if (_correctGuesses[i]) {
            _gameBoard[_currentRow][i] = _targetSequence[i];
          }
        }
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _formattedTime() {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: myAppBar('Mastermind 2025'),
          drawer: myDrawer(context),
          backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Timer Display
                if (_stopwatch.isRunning)
                  Text(
                    'Elapsed Time: ${_formattedTime()}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 10),
                // Difficulty Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Select Difficulty: '),
                    DropdownButton<String>(
                      value: _difficulty,
                      items: _difficulties.map((difficulty) {
                        return DropdownMenuItem(
                          value: difficulty,
                          child: Text(difficulty),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _difficulty = value;
                            _sequenceLength = value == 'Easy'
                                ? 6
                                : value == 'Medium'
                                    ? 8
                                    : 10;
                            _maxTries = value == 'Easy'
                                ? 10
                                : value == 'Medium'
                                    ? 8
                                    : 6;
                            _initializeGame();
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Start Button
                ElevatedButton(
                  onPressed: _startGame,
                  style: getButtonStyle(themeProvider.isDarkMode),
                  child: const Text('Start Game'),
                ),
                const SizedBox(height: 20),
                // Game Board
                Expanded(
                  child: ListView.builder(
                    itemCount: _gameBoard.length,
                    itemBuilder: (context, rowIndex) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            _sequenceLength,
                            (colIndex) => GestureDetector(
                              onTap: () {
                                if (rowIndex == _currentRow && !_gameOver) {
                                  _updateCell(colIndex);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _gameBoard[rowIndex][colIndex],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (rowIndex == _currentRow && !_gameOver)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ElevatedButton(
                                onPressed: _submitRow,
                                style: getButtonStyle(themeProvider.isDarkMode).copyWith(
                                  padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                ),
                                child: const Text('Check'),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                // Play Again Button
                if (_gameOver)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _initializeGame();
                        });
                      },
                      style: getButtonStyle(themeProvider.isDarkMode),
                      child: const Text('Play Again'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
