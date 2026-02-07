import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'daily_goal_screen.dart';

class PreparationScreen extends StatefulWidget {
  final int onboardingId;
  final String selectedLanguage;
  final String learningReason;

  const PreparationScreen({
    super.key,
    required this.onboardingId,
    required this.selectedLanguage,
    required this.learningReason,
  });

  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
  final Set<String> selectedOptions = {};

  final List<Map<String, String>> options = [
    {'title': 'Converse with confidence', 'icon': '💬'},
    {'title': 'Build up your vocabulary', 'icon': '📚'},
    {'title': 'Develop a learning habit', 'icon': '⏰'},
    {'title': 'Improve my grammar', 'icon': '✍️'},
    {'title': 'Understand native speakers', 'icon': '🎧'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Top Progress Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF58CC02)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),

            /// Duo + Question Bubble
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Let's prepare you for conversations!",
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

            /// Options List
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = selectedOptions.contains(option['title']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedOptions.remove(option['title']);
                        } else {
                          selectedOptions.add(option['title']!);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.lightBlue.shade50 : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.lightBlue : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Text(option['icon']!, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Text(
                            option['title']!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_box, color: Colors.blue)
                          else
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Continue Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedOptions.isEmpty
                      ? null
                      : () async {
                          try {
                            await http.post(
                              Uri.parse("http://localhost:5000/api/onboarding/preparations"),
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "onboardingId": widget.onboardingId,
                                "preparations": selectedOptions.toList(),
                              }),
                            );
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyGoalScreen(
                                  onboardingId: widget.onboardingId,
                                  selectedLanguage: widget.selectedLanguage,
                                  learningReason: widget.learningReason,
                                  preparations: selectedOptions.toList(),
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
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
