import '../models/mcq_question.dart';

final List<MCQQuestion> flutterQuestions = [
  const MCQQuestion(
    id: 1,
    question: 'What is Flutter?',
    options: [
      'Programming Language',
      'UI Framework',
      'Database',
      'Operating System',
    ],
    correctAnswer: 1,
    explanation:
        'Flutter is an open-source UI framework developed by Google.',
    subject: 'Flutter',
  ),

  const MCQQuestion(
    id: 2,
    question: 'Which programming language is used by Flutter?',
    options: [
      'Java',
      'Kotlin',
      'Dart',
      'C++',
    ],
    correctAnswer: 2,
    explanation:
        'Flutter applications are primarily developed using Dart.',
    subject: 'Flutter',
  ),

  const MCQQuestion(
    id: 3,
    question: 'Which widget is commonly used for a button in Flutter?',
    options: [
      'TextButton',
      'TextField',
      'Container',
      'Column',
    ],
    correctAnswer: 0,
    explanation:
        'TextButton is one of the button widgets available in Flutter.',
    subject: 'Flutter',
  ),

  const MCQQuestion(
    id: 4,
    question: 'Which file contains Flutter dependencies?',
    options: [
      'main.dart',
      'pubspec.yaml',
      'AndroidManifest.xml',
      'index.html',
    ],
    correctAnswer: 1,
    explanation:
        'pubspec.yaml contains dependencies and project configuration.',
    subject: 'Flutter',
  ),

  const MCQQuestion(
    id: 5,
    question: 'Which widget is used for a vertical layout?',
    options: [
      'Row',
      'Stack',
      'Column',
      'ListTile',
    ],
    correctAnswer: 2,
    explanation:
        'Column arranges its children vertically.',
    subject: 'Flutter',
  ),
];