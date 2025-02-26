import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/colors.dart';
import '../widgets/signup_option_card.dart';

class SignUpOptions extends StatelessWidget {
  const SignUpOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/SignUpOptions-bg.svg',
              fit: BoxFit.fill,
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/LOGO.png', height: 90),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Choose your journey with GO. Connect, explore, and grow with our community.",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              SignUpOptionCard(
                title: "Personal Account",
                description:
                    "Perfect for individuals looking to explore and connect with amazing places and experiences.",
                actionText: "Sign up now",
                icon: Icons.person_outline,
                onTap: () {
                  // Handle sign-up action
                },
              ),
              SignUpOptionCard(
                title: "Business Account",
                description:
                    "Designed for businesses wanting to showcase their locations and connect with more customers.",
                actionText: "Sign up as business",
                icon: Icons.business_outlined,
                onTap: () {
                  // Handle business sign-up
                },
              ),
              SignUpOptionCard(
                title: "Continue as a Guest",
                description:
                    "Explore our platform without creating an account. Limited features available.",
                actionText: "Start exploring",
                icon: FontAwesomeIcons.ghost,
                onTap: () {
                  // Handle guest login
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: GestureDetector(
                  onTap: () {
                    // Handle login navigation
                    Navigator.pushNamed(context, '/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: AppColors.mediumGray,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
