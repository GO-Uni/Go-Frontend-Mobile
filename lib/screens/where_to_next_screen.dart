import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_button.dart';
import '../providers/category_provider.dart';

class WhereToNextScreen extends StatelessWidget {
  const WhereToNextScreen({super.key});

  static const Map<String, String> categoryImages = {
    "Restaurant": "assets/images/restaurant.jpeg",
    "Hotel": "assets/images/hotel.jpeg",
    "Shopping Mall": "assets/images/shopping_mall.jpeg",
    "Entertainment": "assets/images/entertainment.jpeg",
    "Historical Landmarks": "assets/images/historical.png",
    "Natural Wonders": "assets/images/natural.jpg",
    "Sports": "assets/images/sports.jpg",
    "Aquatic Destinations": "assets/images/aquatic.jpeg",
    "Night Life": "assets/images/night_life.jpeg",
    "Outdoor Activities": "assets/images/outdoor.jpeg",
  };

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

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
                child:
                    categoryProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : categoryProvider.categories.isEmpty
                        ? const Center(child: Text("No categories found"))
                        : GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryProvider.categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            final category = categoryProvider.categories[index];
                            final imagePath =
                                categoryImages[category['name']] ??
                                "assets/images/default.jpeg";

                            return CategoryCard(
                              title: category['name'],
                              imagePath: imagePath,
                            );
                          },
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
