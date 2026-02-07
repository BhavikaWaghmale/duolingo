import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'course_building_screen.dart';

class ExperienceLevelScreen extends StatefulWidget {
  final String selectedLanguage;
  final int onboardingId;

  const ExperienceLevelScreen({
    super.key,
    required this.selectedLanguage,
    required this.onboardingId,
  });

  @override
  State<ExperienceLevelScreen> createState() => _ExperienceLevelScreenState();
}

class _ExperienceLevelScreenState extends State<ExperienceLevelScreen> {
  int? selectedIndex;
  bool isLoading = false;

  late List<String> levels;

  @override
  void initState() {
    super.initState();

    levels = [
      "I'm new to ${widget.selectedLanguage}",
      "I know some common words",
      "I can have basic conversations",
      "I can talk about various topics",
      "I can discuss most topics in detail",
    ];
  }

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
                  const Icon(Icons.arrow_back_ios, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.35,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF58CC02),
                      ),
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
                        "How much ${widget.selectedLanguage} do you know?",
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

            /// Options List
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (_, index) {
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
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
                          Icon(
                            Icons.signal_cellular_alt,
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              levels[index],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
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
                  onPressed: selectedIndex == null || isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);

                          try {
                            await ApiService.saveLevel(
                              onboardingId: widget.onboardingId,
                              level: levels[selectedIndex!],
                            );

                            if (!mounted) return;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CourseBuildingScreen(
                                  selectedLanguage: widget.selectedLanguage,
                                  selectedLevel: levels[selectedIndex!],
                                  onboardingId: widget.onboardingId,
                                  count: 100,
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() => isLoading = false);
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == null || isLoading
                        ? Colors.grey.shade300
                        : const Color(0xFF58CC02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
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
