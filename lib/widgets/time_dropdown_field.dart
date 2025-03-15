import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for time formatting
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class TimeDropdownField extends StatelessWidget {
  final String label;
  final String? selectedTime;
  final bool isEditing;
  final ValueChanged<String?> onChanged;

  const TimeDropdownField({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.isEditing,
    required this.onChanged,
  });

  String _convertTo12HourFormat(String? time) {
    if (time == null || time.isEmpty) return "08:00 AM";

    try {
      DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("h:mm a").format(parsedTime);
    } catch (e) {
      return "08:00 AM";
    }
  }

  String _convertTo24HourFormat(String? time) {
    if (time == null || time.isEmpty) return "08:00:00";

    try {
      DateTime parsedTime = DateFormat("h:mm a").parse(time);
      return DateFormat("HH:mm:ss").format(parsedTime);
    } catch (e) {
      return "08:00:00";
    }
  }

  List<String> _generateTimeSlots() {
    List<String> times = [];
    for (int i = 8; i <= 23; i++) {
      DateTime time = DateTime(2000, 1, 1, i, 0);
      times.add(DateFormat("h:mm a").format(time));
      time = DateTime(2000, 1, 1, i, 30);
      times.add(DateFormat("h:mm a").format(time));
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _generateTimeSlots();

    final formattedSelectedTime = _convertTo12HourFormat(selectedTime);

    final validSelectedTime =
        (timeSlots.contains(formattedSelectedTime))
            ? formattedSelectedTime
            : timeSlots.first;

    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 3),

          DropdownButtonFormField<String>(
            value: validSelectedTime,
            decoration: InputDecoration(
              hintText: formattedSelectedTime,
              hintStyle: const TextStyle(
                fontSize: 11,
                color: AppColors.lightGray,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
            ),
            items:
                timeSlots
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value, style: AppTextStyles.bodyRegular),
                      ),
                    )
                    .toList(),

            // Convert selection back to 24-hour format before saving
            onChanged:
                isEditing
                    ? (value) {
                      String formattedValue = _convertTo24HourFormat(value);
                      onChanged(formattedValue);
                    }
                    : null,

            icon: const Icon(Icons.keyboard_arrow_down, size: 20),
            style: AppTextStyles.bodyRegular,
          ),
        ],
      ),
    );
  }
}
