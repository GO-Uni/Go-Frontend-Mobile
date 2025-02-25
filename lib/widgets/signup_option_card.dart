import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/colors.dart';

class SignUpOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final IconData icon;
  final bool isFontAwesome;
  final VoidCallback onTap;

  const SignUpOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    required this.icon,
    this.isFontAwesome = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:
                  isFontAwesome
                      ? FaIcon(icon, size: 38, color: AppColors.darkGray)
                      : Icon(icon, size: 38, color: AppColors.darkGray),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: AppColors.darkGray,
              ),
            ),
            const SizedBox(height: 5),

            // Description
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: AppColors.mediumGray,
              ),
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 20, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
