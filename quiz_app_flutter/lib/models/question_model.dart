class Question {
  final String questionText;
  final String situation;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.situation,
    required this.options,
    required this.correctAnswer,
  });
}
