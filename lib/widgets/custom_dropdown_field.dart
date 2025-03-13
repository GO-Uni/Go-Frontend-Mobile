import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import '../theme/text_styles.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final Function(String?)? onChanged;
  final String? value;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 3),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.lightGreen,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
          ),
          value: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
