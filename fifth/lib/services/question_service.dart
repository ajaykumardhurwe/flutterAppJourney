import '../models/mcq_question.dart';
import 'api_service.dart';

class QuestionService {
  static Future<List<MCQQuestion>> getQuestions() async {
    final data = await ApiService.get('/Questions');

    return (data as List)
        .map(
          (json) => MCQQuestion.fromJson(json),
        )
        .toList();
  }

  static Future<MCQQuestion> getQuestion(
    int id,
  ) async {
    final data = await ApiService.get(
      '/Questions/$id',
    );

    return MCQQuestion.fromJson(data);
  }

  static Future<List<MCQQuestion>>
      getQuestionsBySubject(
    int subjectId,
  ) async {
    final data = await ApiService.get(
      '/Questions/subject/$subjectId',
    );

    return (data as List)
        .map(
          (json) => MCQQuestion.fromJson(json),
        )
        .toList();
  }

  static Future<MCQQuestion> createQuestion(
    MCQQuestion question,
  ) async {
    final data = await ApiService.post(
      '/Questions',
      question.toJson(),
    );

    return MCQQuestion.fromJson(data);
  }

  static Future<MCQQuestion> updateQuestion(
    MCQQuestion question,
  ) async {
    final data = await ApiService.put(
      '/Questions/${question.id}',
      question.toJson(),
    );

    return MCQQuestion.fromJson(data);
  }

  static Future<void> deleteQuestion(
    int id,
  ) async {
    await ApiService.delete(
      '/Questions/$id',
    );
  }
}