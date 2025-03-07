import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/destination_card.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    String? category =
        (extra is Map<String, dynamic>) ? extra["category"] as String? : null;
    bool showCategory = category?.isNotEmpty ?? false;

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Text(
                showCategory ? category! : "Recommended",
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 14, left: 13, right: 13),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: 2, //destinations.length
                  itemBuilder: (context, index) {
                    return DestinationCard(
                      imageUrl:
                          "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
                      name: "Ancient Castle",
                      description: "A historical place",
                      rating: 3,
                    );
                  },
                ),
              ),
            ),

            if (!showCategory)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16),
                child: Text(
                  "All Destinations",
                  style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
                ),
              ),

            if (!showCategory)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 14, left: 13, right: 13),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: 4, //destinations.length
                    itemBuilder: (context, index) {
                      return DestinationCard(
                        imageUrl:
                            "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
                        name: "Ancient Castle",
                        description: "A historical place",
                        rating: 3,

                        // imageUrl: destinations[index].imageUrl,
                        // name: destinations[index].name,
                        // description: destinations[index].description,
                        // rating: destinations[index].rating,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
