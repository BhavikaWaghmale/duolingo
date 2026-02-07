import 'package:flutter/material.dart';

class PlanSelectionScreen extends StatefulWidget {
  final String selectedLanguage;
  final String selectedLevel;

  const PlanSelectionScreen({
    super.key,
    required this.selectedLanguage,
    required this.selectedLevel,
  });

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Plan'),
        backgroundColor: const Color(0xFF58CC02),
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Column(
      children: [
        /// Top bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.9,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF58CC02)),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// Duo + bubble
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/bird4.jpg",
                height: 70,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedPlan == null
                        ? "How do you want to get started?"
                        : "Awesome! You can upgrade anytime.",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        /// Selected language/level summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language: ${widget.selectedLanguage}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text('Level: ${widget.selectedLevel}'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// Super Duolingo Card
        _planCard(
          title: "Super Duolingo",
          subtitle: "Faster progress, no ads",
          isSelected: selectedPlan == "super",
          isRecommended: true,
          onTap: () {
            setState(() {
              selectedPlan = "super";
            });
          },
        ),

        /// Learn for free Card
        _planCard(
          title: "Learn for free",
          subtitle: "Core learning features, with ads",
          isSelected: selectedPlan == "free",
          onTap: () {
            setState(() {
              selectedPlan = "free";
            });
          },
        ),

        const SizedBox(height: 20),

        /// Continue Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: selectedPlan == null
                  ? null
                  : () {
                      // finish onboarding and return to initial screen
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedPlan == null ? Colors.grey.shade300 : const Color(0xFF58CC02),
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "CONTINUE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

    );
  }

  /// Plan card widget
  Widget _planCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    bool isRecommended = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE7F7FF) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? Colors.lightBlue : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isRecommended) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "RECOMMENDED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
