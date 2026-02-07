import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'experience_level_screen.dart';

class DailyGoalScreen extends StatefulWidget {
  final int onboardingId;
  final String selectedLanguage;
  final String learningReason;
  final List<String> preparations;

  const DailyGoalScreen({
    super.key,
    required this.onboardingId,
    required this.selectedLanguage,
    required this.learningReason,
    required this.preparations,
  });

  @override
  State<DailyGoalScreen> createState() => _DailyGoalScreenState();
}

class _DailyGoalScreenState extends State<DailyGoalScreen> {
  String? selectedGoal;

  final List<Map<String, String>> goals = [
    {'title': '5 min / day', 'label': 'Casual'},
    {'title': '10 min / day', 'label': 'Regular'},
    {'title': '15 min / day', 'label': 'Serious'},
    {'title': '20 min / day', 'label': 'Intense'},
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
                      value: 0.75,
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
                        "What's your daily learning goal?",
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

            /// Goals List
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  final isSelected = selectedGoal == goal['title'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = goal['title'];
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
                          Text(
                            goal['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            goal['label']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.blue : Colors.grey,
                              fontWeight: FontWeight.w600,
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
                  onPressed: selectedGoal == null
                      ? null
                      : () async {
                          try {
                            await http.post(
                              Uri.parse("http://localhost:5000/api/onboarding/daily-goal"),
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "onboardingId": widget.onboardingId,
                                "dailyGoal": selectedGoal,
                              }),
                            );
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExperienceLevelScreen(
                                  onboardingId: widget.onboardingId,
                                  selectedLanguage: widget.selectedLanguage,
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
