import 'package:flutter/material.dart';
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

  List<String> _generateTimeSlots() {
    List<String> times = [];
    for (int i = 8; i <= 23; i++) {
      String hour = i > 12 ? (i - 12).toString() : i.toString();
      String period = i >= 12 ? "PM" : "AM";
      times.add("$hour:00 $period");
      times.add("$hour:30 $period");
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _generateTimeSlots();

    final validSelectedTime =
        (selectedTime != null && timeSlots.contains(selectedTime))
            ? selectedTime
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
              hintText: selectedTime ?? "Select time",
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
            onChanged: isEditing ? onChanged : null,
            icon: const Icon(Icons.keyboard_arrow_down, size: 20),
            style: AppTextStyles.bodyRegular,
          ),
        ],
      ),
    );
  }
}
