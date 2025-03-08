import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'custom_button.dart';
import 'booking_slot.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({super.key});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;

  final List<String> _timeSlots = [
    "8:00 am - 8:30 am",
    "9:00 am - 9:30 am",
    "9:30 am - 10:00 am",
  ];

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

        Column(
          children:
              _timeSlots.map((slot) {
                bool isBooked = slot == "8:00 am - 8:30 am";
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
        ),

        const SizedBox(height: 15),

        CustomButton(text: "Confirm Booking", onPressed: () {}, width: 200),
      ],
    );
  }
}
