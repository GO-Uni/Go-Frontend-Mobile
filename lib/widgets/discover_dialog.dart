import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:provider/provider.dart';

class DiscoverDialog extends StatelessWidget {
  const DiscoverDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(35),
      backgroundColor: const Color(0xFFF7FAF8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Discover More of Lebanon!",
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 20,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Sign up now to unlock all features and start exploring Lebanon's rich history, culture, and hidden gems. Join our community of travelers today!",
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  authProvider.continueAsGuest();
                  authProvider.setIsGuest(false);
                  Navigator.of(context).pop();
                  context.go(ConfigRoutes.signUpOptions);
                },
                child: Text(
                  "Sign Up",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
