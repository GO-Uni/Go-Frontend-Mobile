import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class WhereToNextScreen extends StatelessWidget {
  const WhereToNextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Where to next?",
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.darkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
