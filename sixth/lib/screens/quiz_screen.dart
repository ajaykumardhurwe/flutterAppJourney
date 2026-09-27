// import 'package:flutter/material.dart';

// import '../data/mcq_data.dart';

// class QuizScreen extends StatefulWidget {
//   const QuizScreen({super.key});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   int currentQuestion = 0;

//   int? selectedAnswer;

//   int score = 0;

//   bool answerSubmitted = false;

//   @override
//   Widget build(BuildContext context) {
//     final question = flutterQuestions[currentQuestion];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Quiz'),

//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),

//             child: Center(
//               child: Text(
//                 '${currentQuestion + 1}/${flutterQuestions.length}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             LinearProgressIndicator(
//               value:
//                   (currentQuestion + 1) /
//                   flutterQuestions.length,
//             ),

//             const SizedBox(height: 25),

//             Text(
//               'Question ${currentQuestion + 1}',
//               style: TextStyle(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .primary,

//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 12),

//             Text(
//               question.question,
//               style: const TextStyle(
//                 fontSize: 21,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 25),

//             Expanded(
//               child: ListView.builder(
//                 itemCount: question.options.length,

//                 itemBuilder: (context, index) {
//                   return _buildOption(
//                     question.options[index],
//                     index,
//                     question.correctAnswer,
//                   );
//                 },
//               ),
//             ),

//             if (answerSubmitted)
//               Container(
//                 width: double.infinity,

//                 padding: const EdgeInsets.all(15),

//                 margin: const EdgeInsets.only(
//                   bottom: 15,
//                 ),

//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),

//                   color: selectedAnswer ==
//                           question.correctAnswer
//                       ? Colors.green.withValues(alpha: 0.1)
//                       : Colors.red.withValues(alpha: 0.1),
//                 ),

//                 child: Text(
//                   selectedAnswer ==
//                           question.correctAnswer
//                       ? 'Correct! ${question.explanation}'
//                       : 'Wrong! ${question.explanation}',
//                 ),
//               ),

//             SizedBox(
//               width: double.infinity,

//               child: FilledButton(
//                 onPressed: selectedAnswer == null
//                     ? null
//                     : _nextQuestion,

//                 child: Text(
//                   currentQuestion ==
//                           flutterQuestions.length - 1
//                       ? 'Finish Test'
//                       : 'Next Question',
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOption(
//     String option,
//     int index,
//     int correctAnswer,
//   ) {
//     final isSelected = selectedAnswer == index;

//     final isCorrect = index == correctAnswer;

//     Color? backgroundColor;

//     if (answerSubmitted) {
//       if (isCorrect) {
//         backgroundColor =
//             Colors.green.withValues(alpha: 0.15);
//       } else if (isSelected) {
//         backgroundColor =
//             Colors.red.withValues(alpha: 0.15);
//       }
//     }

//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),

//       color: backgroundColor,

//       child: RadioListTile<int>(
//         value: index,

//         groupValue: selectedAnswer,

//         onChanged: answerSubmitted
//             ? null
//             : (value) {
//                 setState(() {
//                   selectedAnswer = value;
//                   answerSubmitted = true;

//                   if (value == correctAnswer) {
//                     score++;
//                   }
//                 });
//               },

//         title: Text(option),

//         secondary: answerSubmitted
//             ? Icon(
//                 isCorrect
//                     ? Icons.check_circle
//                     : isSelected
//                         ? Icons.cancel
//                         : Icons.circle_outlined,
//               )
//             : null,
//       ),
//     );
//   }

//   void _nextQuestion() {
//     if (currentQuestion ==
//         flutterQuestions.length - 1) {
//       _showResult();

//       return;
//     }

//     setState(() {
//       currentQuestion++;

//       selectedAnswer = null;

//       answerSubmitted = false;
//     });
//   }

//   void _showResult() {
//     showDialog(
//       context: context,

//       barrierDismissible: false,

//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Test Completed 🎉'),

//           content: Text(
//             'Your score is $score/${flutterQuestions.length}',
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               },

//               child: const Text('Done'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }




















import 'package:flutter/material.dart';

import '../models/mcq_question.dart';
import '../services/question_service.dart';

class QuizScreen extends StatefulWidget {
  final int? subjectId;
  final String? subjectName;

  const QuizScreen({
    super.key,
    this.subjectId,
    this.subjectName,
  });

  @override
  State<QuizScreen> createState() =>
      _QuizScreenState();
}

class _QuizScreenState
    extends State<QuizScreen> {
  late Future<List<MCQQuestion>>
      questionsFuture;

  int currentQuestion = 0;

  int? selectedAnswer;

  int score = 0;

  bool answerSubmitted = false;

  @override
  void initState() {
    super.initState();

    if (widget.subjectId != null) {
      questionsFuture =
          QuestionService
              .getQuestionsBySubject(
        widget.subjectId!,
      );
    } else {
      questionsFuture =
          QuestionService.getQuestions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subjectName ??
              'MCQ Test',
        ),
      ),

      body: FutureBuilder<
          List<MCQQuestion>>(
        future: questionsFuture,

        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final questions =
              snapshot.data ?? [];

          if (questions.isEmpty) {
            return const Center(
              child: Text(
                'No questions available.',
              ),
            );
          }

          return _buildQuiz(
            context,
            questions,
          );
        },
      ),
    );
  }

  Widget _buildQuiz(
    BuildContext context,
    List<MCQQuestion> questions,
  ) {
    final question =
        questions[currentQuestion];

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          LinearProgressIndicator(
            value:
                (currentQuestion + 1) /
                questions.length,
          ),

          const SizedBox(height: 25),

          Text(
            'Question ${currentQuestion + 1}/${questions.length}',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .primary,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            question.question,
            style: const TextStyle(
              fontSize: 21,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: ListView.builder(
              itemCount:
                  question.options.length,

              itemBuilder:
                  (context, index) {
                return _option(
                  question,
                  index,
                );
              },
            ),
          ),

          if (answerSubmitted)
            _explanation(question),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,

            child: FilledButton(
              onPressed:
                  selectedAnswer == null
                      ? null
                      : () {
                          _nextQuestion(
                            questions,
                          );
                        },

              child: Text(
                currentQuestion ==
                        questions.length - 1
                    ? 'Finish Test'
                    : 'Next Question',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _option(
    MCQQuestion question,
    int index,
  ) {
    final isCorrect =
        index ==
        question.correctAnswer;

    final isSelected =
        selectedAnswer == index;

    Color? color;

    if (answerSubmitted) {
      if (isCorrect) {
        color = Colors.green
            .withValues(alpha: 0.15);
      } else if (isSelected) {
        color = Colors.red
            .withValues(alpha: 0.15);
      }
    }

    return Card(
      color: color,

      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      child: RadioListTile<int>(
        value: index,

        groupValue:
            selectedAnswer,

        onChanged:
            answerSubmitted
                ? null
                : (value) {
                    setState(() {
                      selectedAnswer =
                          value;

                      answerSubmitted =
                          true;

                      if (value ==
                          question
                              .correctAnswer) {
                        score++;
                      }
                    });
                  },

        title: Text(
          question.options[index],
        ),
      ),
    );
  }

  Widget _explanation(
    MCQQuestion question,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(12),

        color:
            Colors.blue.withValues(
          alpha: 0.08,
        ),
      ),

      child: Text(
        question.explanation ??
            'No explanation available.',
      ),
    );
  }

  void _nextQuestion(
    List<MCQQuestion> questions,
  ) {
    if (currentQuestion ==
        questions.length - 1) {
      _showResult(
        questions.length,
      );

      return;
    }

    setState(() {
      currentQuestion++;

      selectedAnswer = null;

      answerSubmitted = false;
    });
  }

  void _showResult(
    int totalQuestions,
  ) {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Test Completed 🎉',
          ),

          content: Text(
            'Your score is '
            '$score/$totalQuestions',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Done',
              ),
            ),
          ],
        );
      },
    );
  }
}