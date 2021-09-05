import 'package:flutter/material.dart';

class HighScoresScreen extends StatelessWidget {
  const HighScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('high_scores_screen'),
        backwardsCompatibility: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('high_scores_screen'),
          ],
        ),
      ),
    );
  }
}