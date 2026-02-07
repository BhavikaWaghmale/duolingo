
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'course_building_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage;
  bool loading = false;

  final List<LanguageItem> languages = [
    LanguageItem("Spanish", "🇪🇸"),
    LanguageItem("French", "🇫🇷"),
    LanguageItem("German", "🇩🇪"),
    LanguageItem("Italian", "🇮🇹"),
    LanguageItem("Intermediate English", "🇺🇸"),
    LanguageItem("Japanese", "🇯🇵"),
  ];

  Future<void> _continue() async {
  if (selectedLanguage == null) return;

  setState(() => loading = true);

  try {
    final response = await http.post(
      Uri.parse("http://localhost:5000/api/onboarding/language"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"language": selectedLanguage}),
    );

    final data = jsonDecode(response.body);

    final int onboardingId = data['onboardingId'];
    final int count = data['count'];

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseBuildingScreen(
          selectedLanguage: selectedLanguage!,
          count: count,
          onboardingId: onboardingId, // ✅ IMPORTANT
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  } finally {
    setState(() => loading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// TOP BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.15,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF58CC02)),
                    ),
                  ),
                ],
              ),
            ),

            /// DUO QUESTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset("assets/images/bird4.jpg", height: 70),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "What would you like to learn?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// LANGUAGE LIST
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (_, index) {
                  final lang = languages[index];
                  final isSelected = selectedLanguage == lang.name;

                  return GestureDetector(
                    onTap: () =>
                        setState(() => selectedLanguage = lang.name),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.lightBlue.shade50
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Colors.lightBlue
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Text(lang.flag,
                              style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Text(
                            lang.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// CONTINUE BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      selectedLanguage == null || loading ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "CONTINUE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageItem {
  final String name;
  final String flag;
  LanguageItem(this.name, this.flag);
}
