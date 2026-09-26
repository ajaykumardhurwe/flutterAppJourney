// {
//   "name": "Flutter",
//   "description": "Flutter MCQ Questions",
//   "isActive": true
// }











class Subject {
  final int id;
  final String name;
  final String? description;
  final bool isActive;

  Subject({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
    };
  }
}