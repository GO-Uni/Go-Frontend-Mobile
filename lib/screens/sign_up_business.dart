import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpBusiness extends StatelessWidget {
  const SignUpBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/SignUpBusiness-bg.svg',
              fit: BoxFit.fill,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome To GO",
                  style: AppTextStyles.headingLarge.copyWith(
                    color: AppColors.darkGray,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign up to begin your journey",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
