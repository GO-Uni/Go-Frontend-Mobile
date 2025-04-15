import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/models/user_model.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import 'custom_button.dart';

class ReviewDialog extends StatefulWidget {
  final int businessUserId;
  final String? profileImageUrl;

  const ReviewDialog({
    super.key,
    required this.businessUserId,
    this.profileImageUrl,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _reviewController = TextEditingController();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    if (profileProvider.user == null) {
      await profileProvider.loadAuthenticatedUser();
    }
    setState(() {
      _user = profileProvider.user;
    });
  }

  Future<void> _handlePostReview() async {
    final reviewText = _reviewController.text.trim();
    if (reviewText.isEmpty) return;

    final activityProvider = Provider.of<ActivityProvider>(
      context,
      listen: false,
    );

    final success = await activityProvider.reviewDestination(
      widget.businessUserId,
      reviewText,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to post review. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _user?.name.isNotEmpty == true
                          ? _user!.name[0].toUpperCase()
                          : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Write your review...",
                          border: InputBorder.none,
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Consumer<ActivityProvider>(
                builder: (context, activityProvider, child) {
                  return CustomButton(
                    text: activityProvider.isLoading ? "Posting..." : "Post",
                    onPressed: () {
                      if (!activityProvider.isLoading) {
                        _handlePostReview();
                      }
                    },
                    width: 150,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
