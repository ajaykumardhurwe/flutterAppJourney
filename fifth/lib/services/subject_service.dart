import '../models/subject.dart';
import 'api_service.dart';

class SubjectService {
  static Future<List<Subject>> getSubjects() async {
    final data = await ApiService.get('/Subjects');

    return (data as List)
        .map(
          (json) => Subject.fromJson(json),
        )
        .toList();
  }

  static Future<Subject> getSubject(int id) async {
    final data = await ApiService.get(
      '/Subjects/$id',
    );

    return Subject.fromJson(data);
  }

  static Future<Subject> createSubject({
    required String name,
    String? description,
  }) async {
    final data = await ApiService.post(
      '/Subjects',
      {
        'name': name,
        'description': description,
        'isActive': true,
      },
    );

    return Subject.fromJson(data);
  }

  static Future<Subject> updateSubject(
    Subject subject,
  ) async {
    final data = await ApiService.put(
      '/Subjects/${subject.id}',
      subject.toJson(),
    );

    return Subject.fromJson(data);
  }

  static Future<void> deleteSubject(int id) async {
    await ApiService.delete(
      '/Subjects/$id',
    );
  }
}