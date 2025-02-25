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
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 90),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/LOGO.png', height: 90),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
