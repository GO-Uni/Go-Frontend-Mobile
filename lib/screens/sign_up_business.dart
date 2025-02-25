import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/custom_text_field.dart';

class SignUpBusiness extends StatelessWidget {
  const SignUpBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SignUpBusiness-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/location-logo.png',
                      fit: BoxFit.fill,
                      height: 70,
                    ),
                    const SizedBox(height: 12),
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
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                label: 'Email',
                hintText: 'Enter your email',
              ),
              const CustomTextField(
                label: "Business Name",
                hintText: "Enter your business name",
              ),
              const CustomTextField(
                label: "Owner Name",
                hintText: "Enter owner name",
              ),
              const CustomTextField(
                label: "Business Category",
                hintText: "Select category",
                isDropdown: true,
              ),
              const CustomTextField(
                label: "Password",
                hintText: "Enter your password",
                isPassword: true,
              ),
              const CustomTextField(
                label: "Confirm Password",
                hintText: "Confirm your password",
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
