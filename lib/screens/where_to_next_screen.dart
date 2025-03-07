import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_router/go_router.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_button.dart';

class WhereToNextScreen extends StatelessWidget {
  const WhereToNextScreen({super.key});

  final List<Map<String, String>> categories = const [
    {"title": "Historical Landmarks", "image": "assets/images/historical.png"},
    {"title": "Natural Wonders", "image": "assets/images/natural.jpg"},
    {"title": "Sports", "image": "assets/images/sports.jpg"},
    {"title": "Historical Landmarks", "image": "assets/images/historical.png"},
    {"title": "Natural Wonders", "image": "assets/images/natural.jpg"},
    {"title": "Sports", "image": "assets/images/sports.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Where to next?",
                  style: AppTextStyles.headingLarge.copyWith(
                    color: AppColors.darkGray,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          title: categories[index]['title']!,
                          imagePath: categories[index]['image']!,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Center(
                child: CustomButton(
                  text: "View All Destinations",
                  onPressed: () {
                    context.go(
                      ConfigRoutes.destinations,
                      extra: {"tabIndex": 0},
                    );
                  },
                  width: 200,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
