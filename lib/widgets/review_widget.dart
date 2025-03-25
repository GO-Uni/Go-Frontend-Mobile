import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final String? profileImageUrl;

  const ReviewCard({
    super.key,
    required this.name,
    required this.review,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Profile Image or Initials
            Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              alignment: Alignment.center,
              child:
                  profileImageUrl != null
                      ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.network(
                          profileImageUrl!,
                          width: 40,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                      : Text(
                        _getInitials(name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.bodyLarge.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
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

  String _getInitials(String name) {
    return name.isNotEmpty
        ? name.split(" ").map((e) => e[0]).take(2).join()
        : "U";
  }
}
