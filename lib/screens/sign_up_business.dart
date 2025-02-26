import 'package:flutter/material.dart';
//import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/welcome_header.dart';

class SignUpBusiness extends StatefulWidget {
  const SignUpBusiness({super.key});

  @override
  SignUpBusinessState createState() => SignUpBusinessState();
}

class SignUpBusinessState extends State<SignUpBusiness> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/SignUpBusiness-bg.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const WelcomeHeader(
                  title: "Welcome To GO",
                  subtitle: "Sign up to begin your journey",
                  imagePath: 'assets/images/location-logo.png',
                ),

                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
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

                const SizedBox(height: 6),

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

                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: AppColors.primary,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text("Bookings", style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 150),
                      IconButton(
                        icon: const Icon(
                          Icons.help_outline,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text("Bookings Help"),
                                  content: const Text(
                                    "Enable this option to allow bookings for your business.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () {
                      // Handle SignUp action
                    },
                    width: 150,
                  ),
                ),

                const SizedBox(height: 15),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle navigation to Login
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGray,
                              ),
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
