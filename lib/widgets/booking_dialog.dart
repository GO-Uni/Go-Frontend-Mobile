import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';

import 'custom_button.dart';
import 'booking_slot.dart';

class BookingDialog extends StatefulWidget {
  final int destinationId;
  const BookingDialog({super.key, required this.destinationId});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;

  List<String> _availableSlots = [];

  @override
  void initState() {
    super.initState();
    final provider = context.read<DestinationProvider>();
    final destination = provider.destinations.firstWhere(
      (dest) => dest['user_id'] == widget.destinationId,
      orElse: () => {},
    );

    log("Destination ID: ${widget.destinationId}");

    log("Destination slots: ${destination['available_booking_slots']}");

    if (destination.isNotEmpty &&
        destination['available_booking_slots'] != null) {
      _availableSlots = List<String>.from(
        destination['available_booking_slots'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
            ),
          ),
        ),

        const SizedBox(height: 4),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              _availableSlots.isNotEmpty
                  ? Column(
                    children:
                        _availableSlots.map((slot) {
                          bool isBooked = false;
                          return BookingSlot(
                            timeSlot: slot,
                            isBooked: isBooked,
                            isSelected: _selectedTimeSlot == slot,
                            onTap: () {
                              setState(() {
                                _selectedTimeSlot = slot;
                              });
                            },
                          );
                        }).toList(),
                  )
                  : const Text("No slots available"),
        ),

        const SizedBox(height: 15),

        CustomButton(text: "Confirm Booking", onPressed: () {}, width: 200),
      ],
    );
  }
}
