import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  final String? title;
  final String subtitle;
  final String imagePath;

  const WelcomeHeader({
    super.key,
    this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, fit: BoxFit.fill, height: 70),
          const SizedBox(height: 12),

          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.darkGray,
              ),
            ),

          const SizedBox(height: 8),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
