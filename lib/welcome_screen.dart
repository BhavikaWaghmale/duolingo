import 'package:flutter/material.dart';
import 'duo_intro_screen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isGetStartedHover = false;
  bool isLoginHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),

              /// Small green text
              Image.asset(
                "assets/images/bird1.jpeg", // use correct image from Figma
                 height: 150,          // ⬅️ increase this (try 60–80)
                 fit: BoxFit.contain,
                ),


              const SizedBox(height: 8),

              /// Duolingo text
              const Text(
                "duolingo",
                style: TextStyle(
                  color: Color(0xFF58CC02),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// Tagline
              const Text(
                "Learn for free. Forever.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              /// GET STARTED BUTTON
              MouseRegion(
                onEnter: (_) => setState(() => isGetStartedHover = true),
                onExit: (_) => setState(() => isGetStartedHover = false),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGetStartedHover
                          ? const Color(0xFF58CC02)
                          : Colors.white,
                      foregroundColor: isGetStartedHover
                          ? Colors.white
                          : const Color(0xFF58CC02),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: const Color(0xFFE5E5E5),
                        ),
                      ),
                    ),
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DuoIntroScreen(),
                            ),
                        );
                    },
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// LOGIN BUTTON
              MouseRegion(
                onEnter: (_) => setState(() => isLoginHover = true),
                onExit: (_) => setState(() => isLoginHover = false),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoginHover
                          ? const Color(0xFF58CC02)
                          : Colors.white,
                      foregroundColor: isLoginHover
                          ? Colors.white
                          : const Color(0xFF58CC02),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color(0xFF58CC02),
                        ),
                      ),
                    ),
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DuoIntroScreen(),
                            ),
                        );
                },
                    child: const Text(
                      "I ALREADY HAVE AN ACCOUNT",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
