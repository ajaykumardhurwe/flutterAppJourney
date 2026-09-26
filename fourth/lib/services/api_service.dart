import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // Android emulator → host computer
  static const String baseUrl =
      'http://10.0.2.2:5265/api';

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  static Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  static Future<void> delete(
    String endpoint,
  ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    _checkResponse(response);
  }

  static void _checkResponse(
    http.Response response,
  ) {
    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'API Error ${response.statusCode}: ${response.body}',
      );
    }
  }
}