// this will contain the score screen

import 'package:flutter/material.dart';
import 'package:mastermind_2025/models/appbar.dart';
import 'package:mastermind_2025/models/drawer.dart';
import 'package:mastermind_2025/models/styles.dart';
import 'package:mastermind_2025/models/save_load.dart';
import 'package:provider/provider.dart';
import 'package:mastermind_2025/models/theme_provider.dart';

class ScoreScreen extends StatelessWidget {
  static const String id = 'score_Screen';

  const ScoreScreen({super.key});

  Future<List<Map<String, dynamic>>> _loadTopScores() async {
    final results = await SaveLoad.loadGameResults();
    if (results != null && results.isNotEmpty) {
      results.sort((a, b) => a['time'].compareTo(b['time']));
      return results.take(10).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          drawer: myDrawer(context),
          appBar: myAppBar('Score'),
          backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _loadTopScores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading scores'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No scores available'));
                    } else {
                      final scores = snapshot.data!;
                      return ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final score = scores[index];
                          return ListTile(
                            title: Center(
                              child: Text(
                                '${score['player']} - ${score['time']}s',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 20.0,),
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                'Tries: ${score['tries']} - ${score['date']}',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              // back button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: getButtonStyle(themeProvider.isDarkMode),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Back',
                    style: getBodyStyle(!themeProvider.isDarkMode),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
