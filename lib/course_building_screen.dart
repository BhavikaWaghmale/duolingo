
import 'package:flutter/material.dart';
import 'experience_level_screen.dart';

class CourseBuildingScreen extends StatefulWidget {
  final String selectedLanguage;
  final int count;
  final int onboardingId;

  const CourseBuildingScreen({
    super.key,
    required this.selectedLanguage,
    required this.count,
    required this.onboardingId,
  });

  @override
  State<CourseBuildingScreen> createState() => _CourseBuildingScreenState();
}

class _CourseBuildingScreenState extends State<CourseBuildingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ExperienceLevelScreen(
            selectedLanguage: widget.selectedLanguage,
            onboardingId: widget.onboardingId,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/bird1.jpeg", height: 150),
              const SizedBox(height: 28),

              const Text(
                "COURSE BUILDING...",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                  color: Colors.black45,
                ),
              ),

              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Get ready to join ${widget.count} people\n"
                  "currently learning ${widget.selectedLanguage} with Duolingo!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
