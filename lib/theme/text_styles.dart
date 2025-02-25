import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: AppColors.mediumGray,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.darkGray,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.mediumGray,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w300, // Light
    color: AppColors.mediumGray,
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600, // SemiBold
    color: Colors.white,
  );

  static const TextStyle highlightText = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}
