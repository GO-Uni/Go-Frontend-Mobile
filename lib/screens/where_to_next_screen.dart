import 'package:flutter/material.dart';
import '../widgets/header.dart';

class WhereToNextScreen extends StatelessWidget {
  const WhereToNextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(children: [const SizedBox(height: 22), const Header()]),
    );
  }
}
