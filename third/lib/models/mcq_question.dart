class MCQQuestion {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String subject;

  const MCQQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.subject,
  });
}