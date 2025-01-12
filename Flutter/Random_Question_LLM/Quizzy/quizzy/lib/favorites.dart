import 'package:flutter/material.dart';
import 'package:quizzy/data/style.dart';
import 'package:quizzy/model.dart';

class FavoritesPage extends StatelessWidget {
  final FunnyQuestionModel _model = FunnyQuestionModel();

  @override
  Widget build(BuildContext context) {

    Future loadFavorites() async {
      return _model.fetchFavoriteQuestions();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Questions')),
      backgroundColor: primaryColor,
      body: FutureBuilder<List<String>>(
        future: _model.fetchFavoriteQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load favorites', 
              style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite questions', 
              style: TextStyle(color: Colors.white)));
          } else {
            final favorites = snapshot.data!;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    favorites[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
