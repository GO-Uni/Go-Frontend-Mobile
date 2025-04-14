import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/widgets/image_selector.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';

class EditBusinessScreen extends StatefulWidget {
  const EditBusinessScreen({super.key});

  @override
  State<EditBusinessScreen> createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {
  String selectedImage = "";
  List<String> images = [];
  String destinationName = "Business Name";
  String district = "Business District";
  String description = "No description available.";
  int? userId;

  final TextEditingController _descriptionController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<ProfileProvider>(context, listen: false).user;

      setState(() {
        images = [
          user?.businessName != null
              ? "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/f9/cd/d0/gardens.jpg?w=900&h=500&s=1"
              : "https://images.pexels.com/photos/2990603/pexels-photo-2990603.jpeg?auto=compress&cs=tinysrgb&w=600",
        ];
        userId = user?.userId;
        selectedImage = images.first;
        destinationName = user?.businessName ?? "Business Name";
        district = user?.district ?? "Business District";
        description =
            user?.businessDescription?.isNotEmpty == true
                ? user!.businessDescription!
                : "No description available.";
        _descriptionController.text = description;
      });
    });
  }

  void _handleProfileUpdateResult(bool success, String? errorMessage) {
    if (success) {
      showCustomSnackBar(
        context: context,
        message: "Description updated successfully!",
        icon: Icons.check_circle_outline,
        backgroundColor: AppColors.primary,
      );
    } else {
      showCustomSnackBar(
        context: context,
        message: errorMessage ?? "Update failed",
        icon: Icons.error_outline,
        backgroundColor: Colors.red,
      );
    }

    setState(() {
      isEditing = false;
      description = _descriptionController.text;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            destinationName,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontSize: 20,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "- $district",
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontSize: 12,
                              color: AppColors.lightGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.location_pin,
                      color: AppColors.darkGreen,
                      size: 30,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    selectedImage.isNotEmpty
                        ? selectedImage
                        : "https://images.pexels.com/photos/2990603/pexels-photo-2990603.jpeg?auto=compress&cs=tinysrgb&w=600",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageSelectorWidget(
                      images: images,
                      selectedImage: selectedImage,
                      onImageSelected: (img) {
                        setState(() {
                          selectedImage = img;
                        });
                      },
                      onImageAdded: (img) {
                        setState(() {
                          images.add(img);
                          selectedImage = img;
                        });
                      },
                    ),

                    IconButton(
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                      onPressed: () async {
                        if (!isEditing) {
                          setState(() => isEditing = true);
                          return;
                        }

                        final profileProvider = Provider.of<ProfileProvider>(
                          context,
                          listen: false,
                        );

                        final success = await profileProvider.updateProfile(
                          businessDescription:
                              _descriptionController.text.trim(),
                        );

                        if (!mounted) return;

                        _handleProfileUpdateResult(
                          success,
                          profileProvider.errorMessage,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    isEditing
                        ? TextField(
                          controller: _descriptionController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: "Enter business description",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkGreen,
                                width: 2,
                              ),
                            ),
                          ),
                          style: AppTextStyles.bodyRegular.copyWith(
                            fontSize: 14,
                            color: AppColors.darkGreen,
                          ),
                        )
                        : Text(
                          description,
                          style: AppTextStyles.bodyRegular.copyWith(
                            fontSize: 14,
                            color: AppColors.mediumGray,
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
