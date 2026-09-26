// class MCQQuestion {
//   final int id;
//   final String question;
//   final List<String> options;
//   final int correctAnswer;
//   final String explanation;
//   final String subject;

//   const MCQQuestion({
//     required this.id,
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//     required this.explanation,
//     required this.subject,
//   });
// }
















class MCQQuestion {
  final int id;

  final String question;

  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  final int correctAnswer;

  final String? explanation;

  final int subjectId;

  final String? subjectName;

  final bool isActive;

  MCQQuestion({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
    this.explanation,
    required this.subjectId,
    this.subjectName,
    required this.isActive,
  });

  List<String> get options => [
        optionA,
        optionB,
        optionC,
        optionD,
      ];

  factory MCQQuestion.fromJson(
    Map<String, dynamic> json,
  ) {
    return MCQQuestion(
      id: json['id'],
      question: json['question'],
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      subjectId: json['subjectId'],
      subjectName: json['subject']?['name'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'subjectId': subjectId,
      'isActive': isActive,
    };
  }
}