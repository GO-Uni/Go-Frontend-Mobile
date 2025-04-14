import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/providers/booking_provider.dart';
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
      final contextRead = context;
      Provider.of<SavedProvider>(
        contextRead,
        listen: false,
      ).fetchSavedDestinations();
      Provider.of<BookingProvider>(
        contextRead,
        listen: false,
      ).fetchBookingsForUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isGuest = authProvider.isGuest;

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Consumer2<SavedProvider, BookingProvider>(
        builder: (context, savedProvider, bookingProvider, _) {
          if (savedProvider.isLoading || bookingProvider.isFetchingBookings) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
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
          final bookedBusinessNames =
              bookingProvider.bookings
                  .map((booking) => booking['business_name']?.toString())
                  .where((name) => name != null)
                  .toSet();

          if (savedDestinations.isEmpty) {
            return const Center(child: Text("No saved destinations found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
            itemCount: savedDestinations.length,
            itemBuilder: (context, index) {
              final destination = savedDestinations[index];
              final isBooked = bookedBusinessNames.contains(
                destination['business_name']?.toString(),
              );

              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: DestinationCard(
                  imageUrl:
                      destination["main_img"] ??
                      "https://images.pexels.com/photos/16414732/pexels-photo-16414732/free-photo-of-ancient-greek-ruin.jpeg?auto=compress&cs=tinysrgb&w=600",
                  name: destination["business_name"] ?? "Unknown",
                  description: destination["description"] ?? "No description",
                  rating: (destination["rating"] as num?)?.toDouble() ?? 0.0,
                  isBooked: isBooked,
                  userid: destination['user_id'],
                  isGuest: isGuest,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
