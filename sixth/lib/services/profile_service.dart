import '../models/user_profile.dart';
import 'api_service.dart';

class ProfileService {
  static Future<List<UserProfile>> getProfiles() async {
    final data = await ApiService.get('/Profiles');

    return (data as List)
        .map(
          (json) => UserProfile.fromJson(json),
        )
        .toList();
  }

  static Future<UserProfile> getProfile(
    int id,
  ) async {
    final data = await ApiService.get(
      '/Profiles/$id',
    );

    return UserProfile.fromJson(data);
  }

  static Future<UserProfile> createProfile({
    required String name,
    required String email,
    String? phone,
    String? bio,
  }) async {
    final data = await ApiService.post(
      '/Profiles',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'bio': bio,
        'isActive': true,
      },
    );

    return UserProfile.fromJson(data);
  }

  static Future<UserProfile> updateProfile(
    UserProfile profile,
  ) async {
    final data = await ApiService.put(
      '/Profiles/${profile.id}',
      profile.toJson(),
    );

    return UserProfile.fromJson(data);
  }

  static Future<void> deleteProfile(
    int id,
  ) async {
    await ApiService.delete(
      '/Profiles/$id',
    );
  }
}