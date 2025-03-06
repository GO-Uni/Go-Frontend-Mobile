import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.email,
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
