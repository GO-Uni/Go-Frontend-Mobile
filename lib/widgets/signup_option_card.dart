import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SignUpOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isSelected;
  final bool enableSelection;

  const SignUpOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    this.icon,
    this.isSelected = false,
    this.enableSelection = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side:
              (enableSelection && isSelected)
                  ? const BorderSide(color: AppColors.primary, width: 1.5)
                  : BorderSide.none,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(icon, size: 38, color: AppColors.darkGray),
                ),
              if (icon != null) const SizedBox(height: 3),

              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 3),

              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: AppColors.mediumGray,
                ),
              ),
              const SizedBox(height: 3),

              Text(
                actionText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
