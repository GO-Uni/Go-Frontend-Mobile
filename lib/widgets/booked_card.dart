import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class BookedCard extends StatelessWidget {
  final String name;
  final String timeRange;

  const BookedCard({super.key, required this.name, required this.timeRange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 70,
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
                color: AppColors.darkGray,
                borderRadius: BorderRadius.only(
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
                          name,
                          style: AppTextStyles.bodyLarge.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 2),
                        Text(
                          timeRange,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
