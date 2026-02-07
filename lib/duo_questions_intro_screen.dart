import 'package:flutter/material.dart';
import 'language_selection_screen.dart';
class DuoQuestionsIntroScreen extends StatelessWidget {
  const DuoQuestionsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            /// Speech Bubble (with pointer)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Just 7 quick questions before we start your lesson!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Triangle pointer under the speech bubble
                //const SizedBox(height: 6),
                Transform.translate(
                  offset: const Offset(0, -1), // overlaps with bubble
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipPath(
                      clipper: _TriangleClipper(),
                      child: Container(
                        width: 26,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(color: Colors.black12),
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            /// Duo Bird
            Image.asset(
              "assets/images/bird1.jpeg",
              height: 200,
            ),

            const Spacer(),

            /// Continue Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LanguageSelectionScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "CONTINUE",
                    style: TextStyle(
                      color: Color(0xFF58CC02),
                      fontWeight: FontWeight.bold,
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

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
