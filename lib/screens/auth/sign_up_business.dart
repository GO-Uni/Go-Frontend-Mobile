import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/welcome_header.dart';

class SignUpBusiness extends StatefulWidget {
  const SignUpBusiness({super.key});

  @override
  SignUpBusinessState createState() => SignUpBusinessState();
}

class SignUpBusinessState extends State<SignUpBusiness> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _businessName = TextEditingController();
  final _ownerName = TextEditingController();
  final _businessCategory = TextEditingController();

  bool isChecked = false;

  void _registerBusiness() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_password.text != _confirmPassword.text) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success = await authProvider.registerUser(
      name: _ownerName.text.trim(),
      email: _email.text.trim().toLowerCase(),
      password: _password.text,
      roleId: 3,
      businessName: _businessName.text,
      businessCategory: _businessCategory.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Business account created successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      context.go(ConfigRoutes.whereToNext);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Signup failed!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
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

                GestureDetector(
                  onTap: () => context.pop(),
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

                const SizedBox(height: 6),

                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _email,
                ),
                CustomTextField(
                  label: "Business Name",
                  hintText: "Enter your business name",
                  controller: _businessName,
                ),
                CustomTextField(
                  label: "Owner Name",
                  hintText: "Enter owner name",
                  controller: _ownerName,
                ),
                CustomTextField(
                  label: "Business Category",
                  hintText: "Select category",
                  isDropdown: true,
                  controller: _businessCategory,
                ),
                CustomTextField(
                  label: "Password",
                  hintText: "Enter your password",
                  isPassword: true,
                  controller: _password,
                ),
                CustomTextField(
                  label: "Confirm Password",
                  hintText: "Confirm your password",
                  isPassword: true,
                  controller: _confirmPassword,
                ),

                Row(
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
                    const SizedBox(width: 170),
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

                const SizedBox(height: 10),

                Center(
                  child: CustomButton(
                    text: "Continue",
                    onPressed: _registerBusiness,
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
