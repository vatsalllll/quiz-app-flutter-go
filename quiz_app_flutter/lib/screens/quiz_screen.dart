import 'package:flutter/material.dart';
import 'result_screen.dart';
import '/models/question_model.dart';
import '../widgets/answer_button.dart';
import 'home_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [
    Question(
      situation:
          'Several media reports that China is considering ending its ban on imports of Australian coal.',
      questionText: 'Will AUD/USD price go up or down?',
      options: ['Up', 'Down'],
      correctAnswer: 'Up',
    ),
    Question(
      situation: 'Alphabet Inc stock price is showing a bear flag pattern.',
      questionText: 'Buy or Sell?',
      options: ['Buy', 'Sell'],
      correctAnswer: 'Sell',
    ),
    Question(
      situation:
          'The Federal Reserve is expected to increase interest rates next month.',
      questionText: 'Will the US dollar strengthen or weaken?',
      options: ['Strengthen', 'Weaken'],
      correctAnswer: 'Strengthen',
    ),
    Question(
      situation: 'Oil prices have fallen by 20% in the past week.',
      questionText: 'Will the stock price of ExxonMobil go up or down?',
      options: ['Up', 'Down'],
      correctAnswer: 'Down',
    ),
    Question(
      situation:
          'There is a rumor that Apple Inc will launch a new iPhone next month.',
      questionText: 'Buy or Sell Apple stock?',
      options: ['Buy', 'Sell'],
      correctAnswer: 'Buy',
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int points = 0;

  void checkAnswer(String selectedAnswer) {
    if (questions[currentQuestionIndex].correctAnswer == selectedAnswer) {
      setState(() {
        score++;
        points += 50; // Add 50 points for each correct answer
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect:
              questions[currentQuestionIndex].correctAnswer == selectedAnswer,
          onContinue: nextQuestion,
          score: score,
          points: points,
        ),
      ),
    );
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      Navigator.pop(context); // Go back to quiz screen
    } else {
      // Quiz finished, show final score
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Quiz Finished!'),
          content: Text(
              'Your score is $score out of ${questions.length}.\nYou earned $points points.'),
          actions: [
            TextButton(
              onPressed: () {
                // Redirect to home page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Question ${currentQuestionIndex + 1} of ${questions.length}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Situation: ${currentQuestion.situation}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset('assets/chart.png'), // Using image instead of icon
          SizedBox(height: 20),
          Text(
            currentQuestion.questionText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...currentQuestion.options.map((option) {
            return AnswerButton(
              text: option,
              onTap: () {
                checkAnswer(option);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
