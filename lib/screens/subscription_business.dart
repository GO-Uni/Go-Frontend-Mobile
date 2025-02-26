import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/welcome_header.dart';
import '../widgets/signup_option_card.dart';

class SubscriptionBusiness extends StatefulWidget {
  const SubscriptionBusiness({super.key});

  @override
  SubscriptionBusinessState createState() => SubscriptionBusinessState();
}

class SubscriptionBusinessState extends State<SubscriptionBusiness> {
  String selectedPlan = "";

  void selectPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 110),

                const WelcomeHeader(
                  subtitle:
                      "Enjoy exclusive benefits with the option to choose between a monthly or yearly subscription.",
                  imagePath: 'assets/images/location-logo.png',
                ),

                const SizedBox(height: 20),

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

                SignUpOptionCard(
                  title: "Monthly Plan",
                  description:
                      "Get access to all features with our monthly subscription—flexible and affordable, billed every month.",
                  actionText: "\$14.99/month",
                  isSelected: selectedPlan == "Monthly",
                  enableSelection: true,
                  onTap: () => selectPlan("Monthly"),
                ),

                SignUpOptionCard(
                  title: "Yearly Plan",
                  description:
                      "Save more with our yearly subscription—enjoy uninterrupted access and exclusive discounts for a full year!",
                  actionText: "\$149.99/year",
                  isSelected: selectedPlan == "Yearly",
                  enableSelection: true,
                  onTap: () => selectPlan("Yearly"),
                ),

                const SizedBox(height: 15),

                Center(
                  child: CustomButton(
                    text: "Subscribe",
                    onPressed: () {
                      if (selectedPlan.isNotEmpty) {
                        //
                      }
                    },
                    width: 150,
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
