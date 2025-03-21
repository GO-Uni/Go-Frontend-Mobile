import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/review_widget.dart';
import '../widgets/review_dialog.dart';
import '../widgets/booking_dialog.dart';

class DetailedDestinationScreen extends StatefulWidget {
  const DetailedDestinationScreen({super.key});

  @override
  State<DetailedDestinationScreen> createState() =>
      _DetailedDestinationScreenState();
}

class _DetailedDestinationScreenState extends State<DetailedDestinationScreen> {
  late String selectedImage;
  late List<String> images;
  bool isBookmarked = false;
  int selectedRating = 3;
  Map<String, dynamic> destination = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final extra = GoRouterState.of(context).extra;
    final destination = (extra is Map<String, dynamic>) ? extra : {};

    images =
        destination["images"]?.cast<String>() ??
        [
          destination["imageUrl"] ??
              "https://images.pexels.com/photos/2990603/pexels-photo-2990603.jpeg?auto=compress&cs=tinysrgb&w=600",
        ];

    selectedImage = images.first;
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ReviewDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          destination["name"] ?? "Destination",
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontSize: 28,
                            color: AppColors.darkGray,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "- ${destination["district"] ?? "Address"}",
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontSize: 16,
                            color: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.location_pin,
                    color: AppColors.darkGreen,
                    size: 30,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  selectedImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Container(
                height: 2,
                width: double.infinity,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thumbnails
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedImage == images[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = images[index];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    images[index],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const BookingDialog();
                            },
                          );
                        },
                        child: Text(
                          "BOOK",
                          style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                        },
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.green : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                destination["description"] ?? "No description available",
                style: AppTextStyles.bodyRegular.copyWith(
                  fontSize: 14,
                  color: AppColors.mediumGray,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Icon(
                      index < selectedRating ? Icons.star : Icons.star,
                      color:
                          index < selectedRating
                              ? Colors.amber
                              : AppColors.lightGray,
                      size: 28,
                    ),
                  );
                }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "REVIEWS",
                    style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: _showReviewDialog,
                    child: const Icon(Icons.add, size: 24),
                  ),
                ],
              ),
            ),

            ReviewCard(
              name: "John Doe",
              review: "Wonderful place! Recommended",
              profileImageUrl: null,
            ),
          ],
        ),
      ),
    );
  }
}
