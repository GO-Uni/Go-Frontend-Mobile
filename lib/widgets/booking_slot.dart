import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class BookingSlot extends StatelessWidget {
  final String timeSlot;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback onTap;

  const BookingSlot({
    super.key,
    required this.timeSlot,
    required this.isBooked,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: isBooked ? null : onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: isBooked ? AppColors.primary : AppColors.darkGray,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeSlot,
                            style: AppTextStyles.bodyRegular.copyWith(
                              fontSize: 16,
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        isBooked ? "BOOKED" : "BOOK",
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 14,
                          color: isBooked ? Colors.green : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
