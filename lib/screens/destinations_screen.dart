import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DestinationsScreen()));
}

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Text(
          "Explore amazing destinations!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
