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
      backgroundColor: Color(0xFF8B64D3), // Match the theme color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                size: 150,
                color: isCorrect ? Colors.green : Colors.red,
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
                    '$points Coins',
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
