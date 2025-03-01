import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/category_card.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 12, right: 12),
            child: Text(
              "Where to next?",
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.darkGray,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 2,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    title: categories[index]['title']!,
                    imagePath: categories[index]['image']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
