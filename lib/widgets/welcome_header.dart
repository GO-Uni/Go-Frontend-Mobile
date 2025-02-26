import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const WelcomeHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.fill, height: 70),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
