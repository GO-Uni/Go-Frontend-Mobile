import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/routes.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/welcome_header.dart';
import '../../theme/text_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.loginUser(
      email: _email.text.trim(),
      password: _password.text.trim(),
    );

    if (!mounted) return;

    log("🔍 Login Success: $success");
    log("🔍 Error Message (if any): ${authProvider.errorMessage}");

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful!"),
          backgroundColor: Colors.green,
        ),
      );
      context.go(ConfigRoutes.whereToNext);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Login failed!"),
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 180),

                const WelcomeHeader(
                  title: "Welcome To GO",
                  subtitle: "Sign in to continue your journey",
                  imagePath: 'assets/images/location-logo.png',
                ),

                const SizedBox(height: 18),

                GestureDetector(
                  onTap: () => context.go(ConfigRoutes.signUpOptions),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Back",
                        style: const TextStyle(
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
                  label: "Password",
                  hintText: "Enter your password",
                  isPassword: true,
                  controller: _password,
                ),

                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: AppColors.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    const Text("Remember me", style: TextStyle(fontSize: 14)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Handle Forgot Password action
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Center(
                  child: CustomButton(
                    text: "Login",
                    onPressed: _login,
                    width: 150,
                  ),
                ),

                const SizedBox(height: 15),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle navigation to Sign Up screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGray,
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                                color: AppColors.primary,
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
