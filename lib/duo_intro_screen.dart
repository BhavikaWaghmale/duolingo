import 'package:flutter/material.dart';
import 'duo_questions_intro_screen.dart';
class DuoIntroScreen extends StatelessWidget {
  const DuoIntroScreen({super.key});

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

              /// Bird + Speech Bubble
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [

                  /// Bird Image
                  Image.asset(
                    "assets/images/bird3.png",
                    height: 200,
                  ),

                  /// Speech Bubble
                  Positioned(
  top: -60,
  child: Column(
    children: [
      /// Speech Bubble Box
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Text(
          "Hi there! I'm Duo!",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      /// Bubble Pointer (Triangle)
      Transform.translate(
        offset: const Offset(0, -1),
        child: Transform.rotate(
          angle: 0.785398, // 45 degrees in radians
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.black12),
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),

                ],
              ),

              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DuoQuestionsIntroScreen(),
                        ),
                    );
                },
                  child: const Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
