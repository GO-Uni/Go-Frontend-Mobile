import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool isDropdown;
  final EdgeInsets? margin;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.isDropdown = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
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
          isDropdown
              ? DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: AppColors.lightGray,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Category 1",
                    child: Text("Category 1"),
                  ),
                  DropdownMenuItem(
                    value: "Category 2",
                    child: Text("Category 2"),
                  ),
                  DropdownMenuItem(
                    value: "Category 3",
                    child: Text("Category 3"),
                  ),
                ],
                onChanged: (value) {
                  // Handle dropdown selection
                },
              )
              : TextField(
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: AppColors.lightGray,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
