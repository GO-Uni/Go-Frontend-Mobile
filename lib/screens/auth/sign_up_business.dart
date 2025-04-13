import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/category_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_frontend_mobile/widgets/custom_dropdown_field.dart';
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

  int? _selectedCategory;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<CategoryProvider>(context, listen: false).loadCategories();
      }
    });
  }

  bool isChecked = false;

  void _continue() async {
    final email = _email.text.trim();
    final businessName = _businessName.text.trim();
    final ownerName = _ownerName.text.trim();
    final password = _password.text;
    final confirmPassword = _confirmPassword.text;

    if (email.isEmpty ||
        businessName.isEmpty ||
        ownerName.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_password.text != _confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a business category."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.go(
      ConfigRoutes.subscriptionBusiness,
      extra: {
        'email': _email.text.trim(),
        'password': _password.text,
        'category_id': _selectedCategory,
        'businessName': _businessName.text.trim(),
        'ownerName': _ownerName.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

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
                  onTap: () => context.go(ConfigRoutes.signUpOptions),
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
                  maxLength: 15,
                ),
                CustomTextField(
                  label: "Owner Name",
                  hintText: "Enter owner name",
                  controller: _ownerName,
                ),

                CustomDropdownField(
                  label: "Business Category",
                  hintText: "Select Category",
                  value: _selectedCategory?.toString(),
                  items:
                      categoryProvider.categories.map((category) {
                        return DropdownMenuItem(
                          value: category['id'].toString(),
                          child: Text(category['name']),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = int.tryParse(value!);
                    });
                  },
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
                    onPressed: _continue,
                    width: 150,
                  ),
                ),

                const SizedBox(height: 15),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.go(ConfigRoutes.signUp);
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
