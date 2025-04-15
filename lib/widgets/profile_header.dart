import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Future<void> _pickImage() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final success = await profileProvider.uploadProfileImage(pickedFile.path);

      if (!mounted) return;

      if (success) {
        await Future.delayed(const Duration(seconds: 4));
      }

      if (!mounted) return;

      showCustomSnackBar(
        context: context,
        message:
            success
                ? "Profile image updated successfully!"
                : "Failed to update profile image.",
        icon: success ? Icons.check_circle_outline : Icons.error_outline,
        backgroundColor: success ? AppColors.primary : Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        final user = profileProvider.user;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user.profileImg != null && user.profileImg!.isNotEmpty)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.profileImg!),
              )
            else
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: _pickImage,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          "Change profile",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (user.roleId == 3) ...[
                        TextButton(
                          onPressed: () {
                            context.go(ConfigRoutes.editDestination);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text(
                            "Edit view page",
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(ConfigRoutes.editLocation);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text(
                            "Edit location",
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
