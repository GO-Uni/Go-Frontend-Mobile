import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Recommended",
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "All Destinations",
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
