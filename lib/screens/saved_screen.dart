import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/providers/booking_provider.dart';
import 'package:go_frontend_mobile/providers/saved_provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/widgets/destination_card.dart';
import 'package:go_frontend_mobile/widgets/discover_dialog.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  bool _dialogShown = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isGuest = context.read<AuthProvider>().isGuest;

    if (isGuest && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showDialog(context: context, builder: (_) => const DiscoverDialog());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = context.watch<AuthProvider>().isGuest;

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
            return isGuest
                ? const SizedBox()
                : Center(
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
            return isGuest
                ? const SizedBox()
                : const Center(child: Text("No saved destinations found."));
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
