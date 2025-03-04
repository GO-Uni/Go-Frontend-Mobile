import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/booked_card.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> bookings = [
      {"name": "Rio", "time": "8:30 am - 9:30 am"},
      {"name": "London", "time": "8:30 am - 9:30 am"},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookedCard(
            name: booking["name"]!,
            timeRange: booking["time"]!,
          );
        },
      ),
    );
  }
}
