import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String? userEmail;
  final int totalPoints;
  final int currentLevel;

  HomeScreen({
    this.userEmail,
    this.totalPoints = 0,
    this.currentLevel = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 61, 235),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.my_location, color: Colors.black), // Aim pointer icon
            SizedBox(width: 8),
            Text(
              'Pattern Sniper™ Quiz',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.black), // Coin icon
              SizedBox(width: 4),
              Text(
                '$totalPoints', // Display total points near the coin icon
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(width: 10),
              if (userEmail == null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                )
              else
                TextButton(
                  child: Text('Logout', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    // TODO: Implement logout functionality
                  },
                ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(
            255, 216, 109, 235), // Apply a single consistent background color
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              userEmail != null
                  ? 'Welcome, $userEmail!'
                  : 'Welcome to Pattern Sniper™ Quiz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Current Level: $currentLevel',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Total Points: $totalPoints',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.greenAccent[400], // Button text color
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Start Quiz',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(level: currentLevel),
                  ),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
