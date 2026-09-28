class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? bio;
  final bool isActive;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.bio,
    required this.isActive,
  });

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'isActive': isActive,
    };
  }
}