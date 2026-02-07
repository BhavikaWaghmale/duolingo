import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'preparation_screen.dart';

class LearningReasonScreen extends StatefulWidget {
  final int onboardingId;
  final String selectedLanguage;

  const LearningReasonScreen({
    super.key,
    required this.onboardingId,
    required this.selectedLanguage,
  });

  @override
  State<LearningReasonScreen> createState() => _LearningReasonScreenState();
}

class _LearningReasonScreenState extends State<LearningReasonScreen> {
  String? selectedReason;

  final List<Map<String, String>> reasons = [
    {'title': 'Just for fun', 'icon': '🎉'},
    {'title': 'Boost my career', 'icon': '💼'},
    {'title': 'Spend time productively', 'icon': '🧠'},
    {'title': 'Connect with people', 'icon': '👨‍👩‍👧‍👦'},
    {'title': 'Prepare for travel', 'icon': '✈️'},
    {'title': 'Support my education', 'icon': '📖'},
    {'title': 'Other', 'icon': '...'},
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
                      value: 0.25,
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
                      child: Text(
                        "Why are you learning ${widget.selectedLanguage}?",
                        style: const TextStyle(
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

            /// Reasons List
            Expanded(
              child: ListView.builder(
                itemCount: reasons.length,
                itemBuilder: (context, index) {
                  final reason = reasons[index];
                  final isSelected = selectedReason == reason['title'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedReason = reason['title'];
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
                          Text(reason['icon']!, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Text(
                            reason['title']!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_circle, color: Colors.blue)
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
                  onPressed: selectedReason == null
                      ? null
                      : () async {
                          try {
                            await http.post(
                              Uri.parse("http://localhost:5000/api/onboarding/reason"),
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "onboardingId": widget.onboardingId,
                                "reason": selectedReason,
                              }),
                            );
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PreparationScreen(
                                  onboardingId: widget.onboardingId,
                                  selectedLanguage: widget.selectedLanguage,
                                  learningReason: selectedReason!,
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
