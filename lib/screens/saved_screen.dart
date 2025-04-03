import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saved_provider.dart';
import '../theme/colors.dart';
import '../widgets/destination_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SavedProvider>(
        context,
        listen: false,
      ).fetchSavedDestinations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Consumer<SavedProvider>(
        builder: (context, savedProvider, _) {
          if (savedProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (savedProvider.error != null) {
            return Center(
              child: Text(
                savedProvider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final savedDestinations = savedProvider.savedDestinations;

          if (savedDestinations.isEmpty) {
            return const Center(child: Text("No saved destinations found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
            itemCount: savedDestinations.length,
            itemBuilder: (context, index) {
              final destination = savedDestinations[index];

              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: DestinationCard(
                  imageUrl:
                      destination["main_img"] ??
                      "https://images.pexels.com/photos/16414732/pexels-photo-16414732/free-photo-of-ancient-greek-ruin.jpeg?auto=compress&cs=tinysrgb&w=600",
                  name: destination["business_name"] ?? "Unknown",
                  description: destination["description"] ?? "No description",
                  rating: (destination["rating"] as num?)?.toDouble() ?? 0.0,
                  isBooked: false,
                  userid: destination['user_id'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
