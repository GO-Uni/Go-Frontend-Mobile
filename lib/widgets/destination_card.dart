import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/activity_provider.dart';
import 'package:go_frontend_mobile/providers/saved_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/text_styles.dart';
import '../services/routes.dart';

class DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double rating;
  final bool? isBooked;
  final String? district;
  final int? userid;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    this.isBooked,
    this.district,
    this.userid,
  });

  @override
  Widget build(BuildContext context) {
    String truncatedDescription =
        description.length > 50
            ? '${description.substring(0, 50)}...'
            : description;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.go(
            ConfigRoutes.detailedDestination,
            extra: {
              "imageUrl": imageUrl,
              "name": name,
              "description": description,
              "rating": rating,
              "district": district,
              "userid": userid,
            },
          );
        },
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 105,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.bodyLarge.copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          truncatedDescription,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color:
                                      index < rating
                                          ? Colors.amber
                                          : Colors.grey,
                                  size: 20,
                                );
                              }),
                            ),
                            const Spacer(),
                            if (userid != null)
                              Consumer2<ActivityProvider, SavedProvider>(
                                builder: (
                                  context,
                                  activityProvider,
                                  savedProvider,
                                  _,
                                ) {
                                  final businessUserId = userid!;
                                  final isSaved = savedProvider.isSaved(
                                    businessUserId,
                                  );

                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () async {
                                        await activityProvider
                                            .toggleSaveDestination(
                                              businessUserId,
                                              isSaved,
                                            );
                                        await savedProvider
                                            .fetchSavedDestinations();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.5),
                                        child: Icon(
                                          isSaved
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color:
                                              isSaved
                                                  ? Colors.green
                                                  : Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            else
                              const Icon(
                                Icons.bookmark_border,
                                size: 18,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Booked or Book tag
              if (isBooked == true)
                Positioned(
                  top: 8,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "Booked",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              else if (isBooked == false)
                Positioned(
                  top: 8,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "Book",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
