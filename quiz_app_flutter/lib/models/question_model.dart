class Question {
  final String questionText;
  final String situation;
  final List<String> options;
  final String correctAnswer;
  final String imagePath; // This is the new field

  Question({
    required this.questionText,
    required this.situation,
    required this.options,
    required this.correctAnswer,
    required this.imagePath, // Initialize it in the constructor
  });
}
