import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool isPassword;
  final bool isDropdown;
  final bool isSubscription;
  final String? subText;
  final EdgeInsets? margin;
  final bool readOnly;
  final VoidCallback? onChangePlan;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.isPassword = false,
    this.isDropdown = false,
    this.isSubscription = false,
    this.subText,
    this.margin,
    this.readOnly = false,
    this.onChangePlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
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

          if (isSubscription)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hintText ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        subText ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onChangePlan,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        "Change plan",
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          if (!isSubscription)
            isDropdown
                ? DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 12,
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
                  items: const [
                    DropdownMenuItem(
                      value: "Category 1",
                      child: Text("Category 1", style: TextStyle(fontSize: 12)),
                    ),
                    DropdownMenuItem(
                      value: "Category 2",
                      child: Text("Category 2", style: TextStyle(fontSize: 12)),
                    ),
                    DropdownMenuItem(
                      value: "Category 3",
                      child: Text("Category 3", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                  onChanged: readOnly ? null : (value) {},
                  icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                )
                : TextField(
                  obscureText: isPassword,
                  style: AppTextStyles.bodyRegular,
                  readOnly: readOnly,
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
                      vertical: 12,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
