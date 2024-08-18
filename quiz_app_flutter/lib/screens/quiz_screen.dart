import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../models/question_model.dart';
import '../widgets/answer_button.dart';
import 'home_screen.dart';

class QuizScreen extends StatefulWidget {
  final int level;
  QuizScreen({required this.level});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int score = 0;
  int points = 0;

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForLevel(widget.level);
  }

  List<Question> getQuestionsForLevel(int level) {
    List<Question> allQuestions = [
      // Level 1 Questions
      Question(
        situation: 'You see a sudden spike in a company\'s stock price.',
        questionText:
            'What is this rapid increase in stock price often called?',
        options: ['Bull run', 'Bear hug', 'Price jump', 'Market rally'],
        correctAnswer: 'Market rally',
        imagePath: 'assets/image1.svg',
      ),
      Question(
        situation:
            'A company announces it will distribute some of its profits to shareholders.',
        questionText: 'What is this distribution called?',
        options: ['Bonus', 'Dividend', 'Interest', 'Capital gain'],
        correctAnswer: 'Dividend',
        imagePath: 'assets/image2.webp',
      ),
      Question(
        situation: 'The overall market is showing a prolonged downward trend.',
        questionText: 'What term is used to describe this market condition?',
        options: [
          'Bear market',
          'Bull market',
          'Stagnant market',
          'Volatile market'
        ],
        correctAnswer: 'Bear market',
        imagePath: 'assets/image3.png',
      ),
      Question(
        situation: 'You want to buy shares of a company.',
        questionText: 'Where would you typically go to purchase these shares?',
        options: [
          'Bank',
          'Stock exchange',
          'Company office',
          'Government treasury'
        ],
        correctAnswer: 'Stock exchange',
        imagePath: 'assets/image4.jpg',
      ),
      Question(
        situation:
            'A company\'s stock price is 100. It announces a 2-for-1 stock split.',
        questionText: 'What will be the new stock price after the split?',
        options: ['200', '100', '50', '25'],
        correctAnswer: '50',
        imagePath: 'assets/image5.jpg',
      ),

      // Level 2 Questions
      Question(
        situation: 'You\'re analyzing a company\'s financial health.',
        questionText:
            'Which ratio would you use to assess a company\'s ability to pay its short-term obligations?',
        options: [
          'P/E ratio',
          'Debt-to-equity ratio',
          'Current ratio',
          'Profit margin'
        ],
        correctAnswer: 'Current ratio',
        imagePath: 'assets/image6.jpg',
      ),
      Question(
        situation: 'A stock\'s price is falling rapidly due to panic selling.',
        questionText:
            'What strategy might a contrarian investor employ in this situation?',
        options: [
          'Sell immediately',
          'Buy more shares',
          'Hold current position',
          'Short sell'
        ],
        correctAnswer: 'Buy more shares',
        imagePath: 'assets/image7.png',
      ),
      Question(
        situation:
            'You\'re considering investing in a new tech startup\'s IPO.',
        questionText: 'What does IPO stand for?',
        options: [
          'Internal Public Offering',
          'Initial Private Offering',
          'Initial Public Offering',
          'Interim Profit Opportunity'
        ],
        correctAnswer: 'Initial Public Offering',
        imagePath: 'assets/image8.png',
      ),
      Question(
        situation:
            'You notice a stock\'s price is moving in the opposite direction of the overall market.',
        questionText:
            'What is the term for the stock\'s relationship with the market in this case?',
        options: [
          'Positive correlation',
          'Negative correlation',
          'No correlation',
          'Market neutrality'
        ],
        correctAnswer: 'Negative correlation',
        imagePath: 'assets/image9.png',
      ),
      Question(
        situation:
            'A company\'s earnings are 5 per share, and its stock price is 75.',
        questionText: 'What is this company\'s P/E (Price-to-Earnings) ratio?',
        options: ['5', '15', '25', '75'],
        correctAnswer: '15',
        imagePath: 'assets/image10.jpg',
      ),

      // Level 3 Questions
      Question(
        situation: 'You\'re analyzing a stock\'s historical volatility.',
        questionText:
            'Which Greek letter is commonly used to represent volatility in options pricing models?',
        options: ['Alpha', 'Beta', 'Gamma', 'Sigma'],
        correctAnswer: 'Sigma',
        imagePath: 'assets/image11.jpg',
      ),
      Question(
        situation: 'You\'re considering a pairs trading strategy.',
        questionText: 'What is the main principle behind pairs trading?',
        options: [
          'Buying two similar stocks',
          'Exploiting price discrepancies between related securities',
          'Always maintaining an equal number of long and short positions',
          'Trading only in pairs of trading sessions'
        ],
        correctAnswer:
            'Exploiting price discrepancies between related securities',
        imagePath: 'assets/image12.webp',
      ),
      Question(
        situation:
            'You\'re analyzing a company using the Dividend Discount Model (DDM).',
        questionText:
            'Which of the following is NOT a key input in the basic DDM?',
        options: [
          'Current stock price',
          'Expected dividend growth rate',
          'Required rate of return',
          'Current dividend'
        ],
        correctAnswer: 'Current stock price',
        imagePath: 'assets/image13.jpg',
      ),
      Question(
        situation: 'You\'re considering the efficient market hypothesis.',
        questionText:
            'Which form of the efficient market hypothesis suggests that even insider information is already reflected in stock prices?',
        options: [
          'Weak form',
          'Semi-strong form',
          'Strong form',
          'Super-strong form'
        ],
        correctAnswer: 'Strong form',
        imagePath: 'assets/image14.jpg',
      ),
      Question(
        situation:
            'You\'re analyzing a stock\'s performance using technical analysis.',
        questionText: 'What does a "golden cross" typically indicate?',
        options: [
          'A bearish trend reversal',
          'A bullish trend reversal',
          'A period of high volatility',
          'A stock split'
        ],
        correctAnswer: 'A bullish trend reversal',
        imagePath: 'assets/imag5.jpg',
      ),
    ];

    int start = (level - 1) * 5;
    int end = start + 5;

    return allQuestions.sublist(start, end);
  }

  void checkAnswer(String selectedAnswer) {
    bool isCorrect =
        questions[currentQuestionIndex].correctAnswer == selectedAnswer;

    if (isCorrect) {
      setState(() {
        score++;
        points += 50 * widget.level; // Points scale with level
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: isCorrect,
          score: score,
          points: points,
          onContinue: () {
            if (currentQuestionIndex < questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
              });
              Navigator.pop(
                  context); // Return to quiz screen for the next question
            } else {
              // Quiz completed for this level
              if (score >= 3) {
                // User passed the level
                if (widget.level < 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(level: widget.level + 1),
                    ),
                  );
                } else {
                  // All levels completed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          totalPoints: points,
                          currentLevel: widget.level,
                          userEmail: null),
                    ),
                  );
                }
              } else {
                // User failed the level, return to home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        totalPoints: points,
                        currentLevel: widget.level,
                        userEmail: null),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Level ${widget.level} - Question ${currentQuestionIndex + 1}'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Image.asset(
              currentQuestion.imagePath,
              width: screenWidth * 0.8,
              height: screenWidth * 0.5,
            ),
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
      ),
    );
  }
}
