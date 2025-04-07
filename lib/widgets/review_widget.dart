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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image or Initials
              Container(
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
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
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Center(
                          child: Text(
                            _getInitials(name),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
              ),

              // Name + Review Text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.bodyLarge.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
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
      ),
    );
  }

  String _getInitials(String name) {
    return name.isNotEmpty
        ? name.split(" ").map((e) => e[0]).take(2).join()
        : "U";
  }
}
