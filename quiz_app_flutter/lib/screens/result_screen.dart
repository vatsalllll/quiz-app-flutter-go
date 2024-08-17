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
      backgroundColor: Color(0xFF8B64D3),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isCorrect
                    ? 'assets/celebration.png' // Image for correct answer
                    : 'assets/sad_face.png', // Image for wrong answer
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                isCorrect ? 'Correct!' : 'Wrong!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  isCorrect
                      ? "Great job! You're getting the hang of this!"
                      : "Don't worry! Keep practicing and you'll improve.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(
                    '$score/5',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.attach_money, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(
                    '\$$points',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onContinue,
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.purple,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
