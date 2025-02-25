import 'package:flutter/material.dart';

class SignUpOptions extends StatelessWidget {
  const SignUpOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/SignUpOptions-bg.png',
              fit: BoxFit.fill,
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 90),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/LOGO.png', height: 90),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Choose your journey with GO. Connect, explore, and grow with our community.",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
