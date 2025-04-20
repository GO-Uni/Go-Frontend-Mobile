import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required IconData icon,
  required Color backgroundColor,
  int durationSeconds = 3,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor.withAlpha((0.95 * 255).toInt()),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: durationSeconds),
    ),
  );
}
