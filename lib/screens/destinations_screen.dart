import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/destination_provider.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../widgets/destination_card.dart';

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({super.key});

  @override
  DestinationsScreenState createState() => DestinationsScreenState();
}

class DestinationsScreenState extends State<DestinationsScreen> {
  String? category;
  bool hasFetched = false;

  final List<Map<String, dynamic>> recommendedDestinations = [
    {
      "main_img":
          "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
      "business_name": "Grand Palace",
      "description": "A beautiful historic palace.",
    },
    {
      "main_img":
          "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
      "business_name": "Mountain View",
      "description": "A breathtaking scenic mountain view.",
    },
    {
      "main_img":
          "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
      "business_name": "Sunset Beach",
      "description": "The perfect place to relax and watch the sunset.",
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDestinations();
    });
  }

  void _fetchDestinations() {
    final extra = GoRouterState.of(context).extra;
    final selectedCategory =
        (extra is Map<String, dynamic>) ? extra["category"] as String? : null;

    final destinationProvider = Provider.of<DestinationProvider>(
      context,
      listen: false,
    );

    if (selectedCategory != null) {
      category = selectedCategory;
      destinationProvider.fetchDestinationsByCategory(category!);
    } else if (!hasFetched) {
      hasFetched = true;
      destinationProvider.fetchAllDestinations();
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinationProvider = Provider.of<DestinationProvider>(context);
    final destinations = destinationProvider.destinations;
    final isLoading = destinationProvider.isLoading;
    final bool showCategory = category?.isNotEmpty ?? false;

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : destinations.isEmpty
              ? const Center(child: Text("No destinations found"))
              : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        bottom: 10,
                      ),
                      child: Text(
                        showCategory ? category! : "Recommended",
                        style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
                      ),
                    ),
                  ),

                  if (!showCategory) ...[
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final destination = recommendedDestinations[index];
                          return DestinationCard(
                            imageUrl:
                                destination["main_img"] ??
                                "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
                            name: destination["business_name"] ?? "Unknown",
                            description:
                                destination["description"] ??
                                "No description available",
                            rating: 5,
                          );
                        }, childCount: recommendedDestinations.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.95,
                            ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 16,
                          bottom: 12,
                        ),
                        child: Text(
                          "All Destinations",
                          style: AppTextStyles.bodyLarge.copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                  ],

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final destination = destinations[index];
                        return DestinationCard(
                          imageUrl:
                              destination["main_img"] ??
                              "https://images.unsplash.com/photo-1726064855757-ac8720008fe0?q=80",
                          name: destination["business_name"] ?? "Unknown",
                          description:
                              destination["description"] ??
                              "No description available",
                          rating: 3,
                          district: destination['district'],
                        );
                      }, childCount: destinations.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.95,
                          ),
                    ),
                  ),
                ],
              ),
    );
  }
}
