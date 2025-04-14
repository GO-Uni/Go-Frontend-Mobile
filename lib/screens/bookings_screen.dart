import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../theme/colors.dart';
import '../widgets/booked_card.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingProvider = Provider.of<BookingProvider>(
        context,
        listen: false,
      );
      bookingProvider.fetchBookingsForUser();
    });
  }

  String formatTimeRange(String isoTime) {
    final dateTime = DateTime.parse(isoTime).toLocal();
    final timeFormat = DateFormat('hh:mm a');
    final startTime = timeFormat.format(dateTime);
    final endTime = timeFormat.format(dateTime.add(Duration(hours: 1)));
    return '$startTime - $endTime';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body:
          provider.isFetchingBookings
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
              : provider.bookings.isEmpty
              ? const Center(child: Text("No bookings yet"))
              : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                physics: const BouncingScrollPhysics(),
                itemCount: provider.bookings.length,
                itemBuilder: (context, index) {
                  final booking = provider.bookings[index];
                  final name = booking["business_name"] ?? "Unknown";
                  final timeRange = formatTimeRange(booking["booking_time"]);

                  return BookedCard(
                    name: name,
                    timeRange: timeRange,
                    onTap: () async {
                      log("Tapped on $name at $timeRange");

                      // Capture context-dependent objects now.
                      final goRouter = GoRouter.of(context);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final destinationProvider =
                          Provider.of<DestinationProvider>(
                            context,
                            listen: false,
                          );

                      try {
                        await destinationProvider.fetchDestinationsByName(name);

                        if (!mounted) {
                          return;
                        }

                        final List destinations =
                            destinationProvider.searchDestinations;
                        if (destinations.isNotEmpty) {
                          final destination = destinations.first;

                          goRouter.go(
                            ConfigRoutes.detailedDestination,
                            extra: {
                              "imageUrl": destination['main_img'],
                              "name": destination['business_name'],
                              "description": destination['description'],
                              "rating": destination['rating'],
                              "district": destination['district'],
                              "userid": destination['user_id'],
                            },
                          );
                        } else {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Destination not found"),
                            ),
                          );
                        }
                      } catch (e) {
                        if (!mounted) {
                          return;
                        }
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text("Something went wrong")),
                        );
                      }
                    },
                  );
                },
              ),
    );
  }
}
