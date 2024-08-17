import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool isCorrect;
  final VoidCallback onContinue;
  final int score;
  final int points;

  ResultScreen({
    required this.isCorrect,
    required this.onContinue,
    required this.score,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCorrect ? '🎉 Correct!' : '❌ Wrong!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Total Score: $score',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow, size: 30.0),
                SizedBox(width: 5),
                Text(
                  '$points Points',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onContinue,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
