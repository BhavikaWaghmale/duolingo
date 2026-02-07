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

  /// STEP 1: Save language + get count + onboardingId
  static Future<Map<String, dynamic>> saveLanguage(String language) async {
    final response = await http.post(
      Uri.parse('$baseUrl/onboarding/language'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'language': language}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save language');
    }

    return jsonDecode(response.body);
  }

  /// STEP 2: Save experience level
  static Future<void> saveLevel({
    required int onboardingId,
    required String level,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/onboarding/level'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'onboardingId': onboardingId,
        'level': level,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save experience level');
    }
  }

  /// OPTIONAL: Get count separately (already included in step 1)
  static Future<int> fetchLanguageCount(String language) async {
    final res = await http.get(
      Uri.parse('$baseUrl/onboarding/count/$language'),
    );

    final data = jsonDecode(res.body);
    return data['count'];
  }
}
