import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  final SplashController controller = Get.find<SplashController>();

  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset(
                'assets/animations/meditation.json', // Ensure the path is correct
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'MANIFAST',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade50,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Manifest your dreams into reality',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple.shade50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
