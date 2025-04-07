import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Image(
                image: AssetImage('assets/images/LOGO.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
