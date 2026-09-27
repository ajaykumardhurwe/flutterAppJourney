
import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../models/mcq_question.dart';
import '../services/subject_service.dart';
import '../services/question_service.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  late Future<List<Subject>> subjectsFuture;

  @override
  void initState() {
    super.initState();
    _reloadSubjects();
  }

  void _reloadSubjects() {
    subjectsFuture = SubjectService.getSubjects();
  }

  Future<void> _refreshSubjects() async {
    setState(() {
      _reloadSubjects();
    });

    await subjectsFuture;
  }

  // ------------------------------------------------------------
  // ADD SUBJECT
  // ------------------------------------------------------------

  Future<void> _addSubject() async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Subject'),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                final name =
                    nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(dialogContext)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter subject name',
                      ),
                    ),
                  );

                  return;
                }

                try {
                  await SubjectService.createSubject(
                    name: name,
                    description:
                        descriptionController.text
                            .trim()
                            .isEmpty
                        ? null
                        : descriptionController.text
                            .trim(),
                  );

                  if (!dialogContext.mounted) return;

                  Navigator.of(dialogContext).pop(true);
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error: $e',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    descriptionController.dispose();

    if (!mounted) return;

    if (result == true) {
      setState(() {
        _reloadSubjects();
      });
    }
  }

  // ------------------------------------------------------------
  // EDIT SUBJECT
  // ------------------------------------------------------------

  Future<void> _editSubject(Subject subject) async {
    final nameController = TextEditingController(
      text: subject.name,
    );

    final descriptionController = TextEditingController(
      text: subject.description ?? '',
    );

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Subject'),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                final name =
                    nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(dialogContext)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter subject name',
                      ),
                    ),
                  );

                  return;
                }

                final updatedSubject = Subject(
                  id: subject.id,
                  name: name,
                  description:
                      descriptionController.text
                          .trim()
                          .isEmpty
                      ? null
                      : descriptionController.text
                          .trim(),
                  isActive: subject.isActive,
                );

                try {
                  await SubjectService.updateSubject(
                    updatedSubject,
                  );

                  if (!dialogContext.mounted) return;

                  Navigator.of(dialogContext).pop(true);
                } catch (e) {
                  if (!dialogContext.mounted) return;

                  ScaffoldMessenger.of(dialogContext)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error: $e',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    descriptionController.dispose();

    if (!mounted) return;

    if (result == true) {
      setState(() {
        _reloadSubjects();
      });
    }
  }

  // ------------------------------------------------------------
  // DELETE SUBJECT
  // ------------------------------------------------------------

  Future<void> _deleteSubject(Subject subject) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Subject'),

          content: Text(
            'Are you sure you want to delete '
            '"${subject.name}"?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await SubjectService.deleteSubject(
        subject.id,
      );

      if (!mounted) return;

      setState(() {
        _reloadSubjects();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Subject deleted successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // OPEN QUESTIONS
  // ------------------------------------------------------------

  void _showQuestions(Subject subject) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return QuestionsScreen(
            subject: subject,
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD SUBJECT SCREEN
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addSubject,
        child: const Icon(Icons.add),
      ),

      body: FutureBuilder<List<Subject>>(
        future: subjectsFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Failed to load subjects',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: _refreshSubjects,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final subjects = snapshot.data ?? [];

          if (subjects.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshSubjects,

              child: ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),

                children: const [
                  SizedBox(height: 180),

                  Center(
                    child: Text(
                      'No subjects found',
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshSubjects,

            child: ListView.builder(
              padding: const EdgeInsets.all(12),

              itemCount: subjects.length,

              itemBuilder: (context, index) {
                final subject = subjects[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    leading: CircleAvatar(
                      child: Text(
                        '${index + 1}',
                      ),
                    ),

                    title: Text(
                      subject.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle:
                        subject.description == null ||
                                subject.description!
                                    .trim()
                                    .isEmpty
                            ? null
                            : Text(
                                subject.description!,
                              ),

                    // Open questions
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Questions',
                          icon: const Icon(
                            Icons.quiz_outlined,
                          ),
                          onPressed: () {
                            _showQuestions(subject);
                          },
                        ),

                        IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(
                            Icons.edit_outlined,
                          ),
                          onPressed: () {
                            _editSubject(subject);
                          },
                        ),

                        IconButton(
                          tooltip: 'Delete',
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () {
                            _deleteSubject(subject);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// QUESTIONS SCREEN
// ============================================================================

class QuestionsScreen extends StatefulWidget {
  final Subject subject;

  const QuestionsScreen({
    super.key,
    required this.subject,
  });

  @override
  State<QuestionsScreen> createState() =>
      _QuestionsScreenState();
}

class _QuestionsScreenState
    extends State<QuestionsScreen> {
  late Future<List<MCQQuestion>> questionsFuture;

  @override
  void initState() {
    super.initState();

    questionsFuture =
        QuestionService.getQuestionsBySubject(
      widget.subject.id,
    );
  }

  // ------------------------------------------------------------
  // RELOAD QUESTIONS
  // ------------------------------------------------------------

  Future<void> _reloadQuestions() async {
    setState(() {
      questionsFuture =
          QuestionService.getQuestionsBySubject(
        widget.subject.id,
      );
    });

    await questionsFuture;
  }

  // ------------------------------------------------------------
  // ADD QUESTION
  // ------------------------------------------------------------

  Future<void> _addQuestion() async {
    final result =
        await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) {
          return AddQuestionScreen(
            subject: widget.subject,
          );
        },
      ),
    );

    if (!mounted) return;

    if (result == true) {
      await _reloadQuestions();
    }
  }

  // ------------------------------------------------------------
  // DELETE QUESTION
  // ------------------------------------------------------------

  Future<void> _deleteQuestion(
    MCQQuestion question,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Question'),

          content: const Text(
            'Are you sure you want to delete this question?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await QuestionService.deleteQuestion(
        question.id,
      );

      if (!mounted) return;

      await _reloadQuestions();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Question deleted successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // QUESTION OPTION
  // ------------------------------------------------------------

  Widget _optionTile({
    required String label,
    required String text,
    required int answerNumber,
    required int correctAnswer,
  }) {
    final isCorrect =
        answerNumber == correctAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 6,
      ),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withValues(alpha: 0.10)
            : null,

        borderRadius:
            BorderRadius.circular(8),

        border: Border.all(
          color: isCorrect
              ? Colors.green
              : Colors.grey.shade300,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCorrect
                  ? Colors.green
                  : null,
            ),
          ),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isCorrect
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),

          if (isCorrect)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD QUESTIONS SCREEN
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subject.name} - Questions',
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: _addQuestion,
        icon: const Icon(Icons.add),
        label: const Text('Add Question'),
      ),

      body: FutureBuilder<List<MCQQuestion>>(
        future: questionsFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Failed to load questions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: _reloadQuestions,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final questions =
              snapshot.data ?? [];

          if (questions.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reloadQuestions,

              child: ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),

                children: const [
                  SizedBox(height: 180),

                  Center(
                    child: Text(
                      'No questions found',
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reloadQuestions,

            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                100,
              ),

              itemCount: questions.length,

              itemBuilder: (context, index) {
                final question =
                    questions[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 14,
                  ),

                  child: Padding(
                    padding:
                        const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Expanded(
                              child: Text(
                                '${index + 1}. '
                                '${question.question}',

                                style:
                                    const TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                              tooltip: 'Delete',
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteQuestion(
                                  question,
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        _optionTile(
                          label: 'A.',
                          text: question.optionA,
                          answerNumber: 1,
                          correctAnswer:
                              question.correctAnswer,
                        ),

                        _optionTile(
                          label: 'B.',
                          text: question.optionB,
                          answerNumber: 2,
                          correctAnswer:
                              question.correctAnswer,
                        ),

                        _optionTile(
                          label: 'C.',
                          text: question.optionC,
                          answerNumber: 3,
                          correctAnswer:
                              question.correctAnswer,
                        ),

                        _optionTile(
                          label: 'D.',
                          text: question.optionD,
                          answerNumber: 4,
                          correctAnswer:
                              question.correctAnswer,
                        ),

                        if (question.explanation !=
                                null &&
                            question.explanation!
                                .trim()
                                .isNotEmpty) ...[
                          const SizedBox(height: 14),

                          const Text(
                            'Explanation',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            question.explanation!,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// ADD QUESTION SCREEN
// ============================================================================

class AddQuestionScreen extends StatefulWidget {
  final Subject subject;

  const AddQuestionScreen({
    super.key,
    required this.subject,
  });

  @override
  State<AddQuestionScreen> createState() =>
      _AddQuestionScreenState();
}

class _AddQuestionScreenState
    extends State<AddQuestionScreen> {
  final questionController =
      TextEditingController();

  final optionAController =
      TextEditingController();

  final optionBController =
      TextEditingController();

  final optionCController =
      TextEditingController();

  final optionDController =
      TextEditingController();

  final explanationController =
      TextEditingController();

  int correctAnswer = 1;

  bool isSaving = false;

  String? errorMessage;

  @override
  void dispose() {
    questionController.dispose();
    optionAController.dispose();
    optionBController.dispose();
    optionCController.dispose();
    optionDController.dispose();
    explanationController.dispose();

    super.dispose();
  }

  // ------------------------------------------------------------
  // SAVE QUESTION
  // ------------------------------------------------------------

  Future<void> _saveQuestion() async {
    FocusScope.of(context).unfocus();

    final questionText =
        questionController.text.trim();

    final optionA =
        optionAController.text.trim();

    final optionB =
        optionBController.text.trim();

    final optionC =
        optionCController.text.trim();

    final optionD =
        optionDController.text.trim();

    if (questionText.isEmpty ||
        optionA.isEmpty ||
        optionB.isEmpty ||
        optionC.isEmpty ||
        optionD.isEmpty) {
      setState(() {
        errorMessage =
            'Please fill all required fields.';
      });

      return;
    }

    setState(() {
      isSaving = true;
      errorMessage = null;
    });

    final question = MCQQuestion(
      id: 0,

      question: questionText,

      optionA: optionA,

      optionB: optionB,

      optionC: optionC,

      optionD: optionD,

      correctAnswer: correctAnswer,

      explanation:
          explanationController.text
                  .trim()
                  .isEmpty
              ? null
              : explanationController.text
                  .trim(),

      subjectId: widget.subject.id,

      subjectName: widget.subject.name,

      isActive: true,
    );

    try {
      await QuestionService.createQuestion(
        question,
      );

      if (!mounted) return;

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
        errorMessage = e.toString();
      });
    }
  }

  // ------------------------------------------------------------
  // BUILD ADD QUESTION SCREEN
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // Subject
              Text(
                'Subject: ${widget.subject.name}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Question
              TextField(
                controller: questionController,
                maxLines: 4,

                decoration:
                    const InputDecoration(
                  labelText: 'Question *',
                  hintText:
                      'Enter your question',
                  border:
                      OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 16),

              // Option A
              TextField(
                controller: optionAController,

                decoration:
                    const InputDecoration(
                  labelText: 'Option A *',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // Option B
              TextField(
                controller: optionBController,

                decoration:
                    const InputDecoration(
                  labelText: 'Option B *',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // Option C
              TextField(
                controller: optionCController,

                decoration:
                    const InputDecoration(
                  labelText: 'Option C *',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // Option D
              TextField(
                controller: optionDController,

                decoration:
                    const InputDecoration(
                  labelText: 'Option D *',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // Correct answer
              const Text(
                'Correct Answer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<int>(
                initialValue: correctAnswer,

                decoration:
                    const InputDecoration(
                  border:
                      OutlineInputBorder(),
                  labelText:
                      'Select correct answer',
                ),

                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Option A'),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text('Option B'),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child: Text('Option C'),
                  ),

                  DropdownMenuItem(
                    value: 4,
                    child: Text('Option D'),
                  ),
                ],

                onChanged: isSaving
                    ? null
                    : (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          correctAnswer =
                              value;
                        });
                      },
              ),

              const SizedBox(height: 16),

              // Explanation
              TextField(
                controller:
                    explanationController,

                maxLines: 4,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Explanation (optional)',
                  hintText:
                      'Enter explanation',
                  border:
                      OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              // Error
              if (errorMessage != null) ...[
                const SizedBox(height: 16),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.red
                        .withValues(alpha: 0.10),

                    borderRadius:
                        BorderRadius.circular(8),

                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),

                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed:
                      isSaving
                          ? null
                          : _saveQuestion,

                  icon: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.save,
                        ),

                  label: Text(
                    isSaving
                        ? 'Saving...'
                        : 'Save Question',
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

