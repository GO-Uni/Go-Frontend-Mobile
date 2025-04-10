import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';

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
      final user = Provider.of<AuthProvider>(context, listen: false).user;

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

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);

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
                child: Image.network(
                  selectedImage.isNotEmpty
                      ? selectedImage
                      : "https://images.pexels.com/photos/2990603/pexels-photo-2990603.jpeg?auto=compress&cs=tinysrgb&w=600",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
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
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedImage == images[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = images[index];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      images[index],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withAlpha(100),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                      onPressed: () async {
                        if (isEditing) {
                          final profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false,
                          );

                          final success = await profileProvider.updateProfile(
                            businessDescription:
                                _descriptionController.text.trim(),
                            onUpdate: (updatedUser) {
                              if (!mounted) return;
                              setState(() {
                                description =
                                    updatedUser.businessDescription ?? "";
                              });
                            },
                          );

                          if (!mounted) return;

                          if (success) {
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Description updated successfully!',
                                ),
                              ),
                            );
                          } else {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  profileProvider.errorMessage ??
                                      'Update failed',
                                ),
                              ),
                            );
                          }
                        }

                        if (!mounted) return;
                        setState(() {
                          isEditing = !isEditing;
                          if (!isEditing) {
                            description = _descriptionController.text;
                          }
                        });
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
