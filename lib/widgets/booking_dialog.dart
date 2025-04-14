import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';
import 'package:go_frontend_mobile/providers/booking_provider.dart';

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
  List<String> _bookedSlotsForSelectedDate = [];

  Map<String, dynamic> _destination = {};

  @override
  void initState() {
    super.initState();

    final destinationProvider = context.read<DestinationProvider>();
    _destination = destinationProvider.destinations.firstWhere(
      (dest) => dest['user_id'] == widget.destinationId,
      orElse: () => {},
    );

    log("Destination ID: ${widget.destinationId}");
    log("Destination slots: ${_destination['available_booking_slots']}");
    log("Initial booked slots: ${_destination['bookings']}");

    if (_destination.isNotEmpty &&
        _destination['available_booking_slots'] != null) {
      _availableSlots = List<String>.from(
        _destination['available_booking_slots'],
      );
    }

    final bookingProvider = context.read<BookingProvider>();

    Future.microtask(() async {
      await bookingProvider.fetchBookingsForBusinessUser(widget.destinationId);

      if (!mounted) return;

      setState(() {
        _destination['bookings'] = bookingProvider.bookings;
      });

      _updateBookedSlotsForDate(_selectedDate);
    });
  }

  void _updateBookedSlotsForDate(DateTime selectedDate) {
    final List<dynamic> bookings = _destination['bookings'] ?? [];

    final slots =
        bookings
            .where((booking) {
              final bookingDate = DateTime.tryParse(booking['booking_date']);
              return bookingDate != null &&
                  isSameDay(bookingDate, selectedDate);
            })
            .map<String>((booking) {
              final time = DateTime.tryParse(booking['booking_time']);
              return time != null
                  ? "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}"
                  : "";
            })
            .where((slot) => slot.isNotEmpty)
            .toList();

    log(
      "⛔ Booked slots on ${selectedDate.toIso8601String().split("T")[0]}: $slots",
    );

    setState(() {
      _bookedSlotsForSelectedDate = slots;
      _selectedTimeSlot = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();

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
                _updateBookedSlotsForDate(selectedDay);
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              _availableSlots.isNotEmpty
                  ? SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _availableSlots.length,
                      itemBuilder: (context, index) {
                        final slot = _availableSlots[index];
                        final isBooked = _bookedSlotsForSelectedDate.contains(
                          slot,
                        );
                        return BookingSlot(
                          timeSlot: slot,
                          isBooked: isBooked,
                          isSelected: _selectedTimeSlot == slot,
                          onTap: () {
                            if (!isBooked) {
                              setState(() {
                                _selectedTimeSlot = slot;
                              });
                            }
                          },
                        );
                      },
                    ),
                  )
                  : const Text("No slots available"),
        ),
        const SizedBox(height: 15),
        CustomButton(
          text: bookingProvider.isLoading ? "Booking..." : "Confirm Booking",
          width: 200,
          onPressed: () {
            if (!bookingProvider.isLoading) _handleBooking();
          },
        ),
      ],
    );
  }

  void _handleBooking() {
    final bookingProvider = context.read<BookingProvider>();

    if (_selectedTimeSlot == null) {
      showCustomSnackBar(
        context: context,
        message: "Please select a time slot.",
        icon: Icons.check_circle_outline,
        backgroundColor: AppColors.primary,
      );
      return;
    }

    final date = _selectedDate.toIso8601String().split("T")[0];

    Future.microtask(() async {
      await bookingProvider.bookActivity(
        businessUserId: widget.destinationId,
        bookingDate: date,
        bookingTime: _selectedTimeSlot!,
      );

      await bookingProvider.fetchBookingsForBusinessUser(widget.destinationId);
      setState(() {
        _destination['bookings'] = bookingProvider.bookings;
      });

      if (!mounted) return;

      if (bookingProvider.bookingSuccess) {
        Navigator.pop(context);
        showCustomSnackBar(
          context: context,
          message: "Booking confirmed.",
          icon: Icons.check_circle_outline,
          backgroundColor: AppColors.primary,
        );
      } else {
        showCustomSnackBar(
          context: context,
          message: bookingProvider.errorMessage ?? "Booking failed",
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      }
    });
  }
}
