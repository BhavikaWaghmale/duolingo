import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000/api';
    } else {
      return 'http://10.0.2.2:5000/api';
    }
  }

  // STEP 1
  static Future<Map<String, dynamic>> saveLanguage(String language) async {
    final response = await http.post(
      Uri.parse('$baseUrl/onboarding/language'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'language': language}),
    );

    print('LANG STATUS: ${response.statusCode}');
    print('LANG BODY: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Failed to save language');
    }

    return jsonDecode(response.body);
  }

  // STEP 2
  static Future<void> saveLevel({
    required int onboardingId,
    required String level,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/onboarding/level'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'onboardingId': onboardingId, 'level': level}),
    );

    print('LEVEL STATUS: ${response.statusCode}');
    print('LEVEL BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to save experience level');
    }
  }
}
