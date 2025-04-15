import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/welcome_header.dart';
import '../../widgets/signup_option_card.dart';
import '../../providers/auth_provider.dart';

class SubscriptionBusiness extends StatefulWidget {
  final String email;
  final String password;
  final int businessCategory;
  final String ownerName;
  final String businessName;

  const SubscriptionBusiness({
    super.key,
    required this.email,
    required this.password,
    required this.businessCategory,
    required this.ownerName,
    required this.businessName,
  });

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

  void _subscribe() async {
    if (selectedPlan.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: "Please select a subscription plan.",
        icon: Icons.lock_outline,
        backgroundColor: Colors.red,
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.registerUser(
      name: widget.ownerName,
      email: widget.email,
      password: widget.password,
      roleId: 3,
      businessName: widget.businessName,
      businessCategory: widget.businessCategory,
      subscriptionType: selectedPlan.toLowerCase(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Subscription successful!"),
          backgroundColor: Colors.green,
        ),
      );
      context.go(ConfigRoutes.whereToNext);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Subscription failed!"),
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
                    onTap: () => context.go(ConfigRoutes.signUpBusiness),
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
                  isSelected: selectedPlan == "monthly",
                  enableSelection: true,
                  onTap: () => selectPlan("monthly"),
                ),

                SignUpOptionCard(
                  title: "Yearly Plan",
                  description:
                      "Save more with our yearly subscription—enjoy uninterrupted access and exclusive discounts for a full year!",
                  actionText: "\$149.99/year",
                  isSelected: selectedPlan == "yearly",
                  enableSelection: true,
                  onTap: () => selectPlan("yearly"),
                ),

                const SizedBox(height: 15),

                Center(
                  child: CustomButton(
                    text: "Subscribe",
                    onPressed: _subscribe,
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
