import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/img_provider.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/widgets/image_selector.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/widgets/panorama_viewer.dart';

class EditBusinessScreen extends StatefulWidget {
  const EditBusinessScreen({super.key});

  @override
  State<EditBusinessScreen> createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {
  String selectedImage = "";
  bool selectedIs360 = false;

  String destinationName = "Business Name";
  String district = "Business District";
  String description = "No description available.";
  int? userId;

  final TextEditingController _descriptionController = TextEditingController();
  bool isEditing = false;
  bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      final user = profileProvider.user;

      if (user == null || user.userId == null) return;

      userId = user.userId!;

      final imgProvider = Provider.of<ImgProvider>(context, listen: false);
      await imgProvider.fetchImages(userId!);

      setState(() {
        // Instead of mapping to a List<String>, we retrieve the raw image data.
        final List<dynamic> imgs = imgProvider.images;
        if (imgs.isNotEmpty) {
          final firstImg = imgs.first as Map<String, dynamic>;
          selectedImage =
              firstImg['url'] ??
              "https://goapp-assets.s3.eu-north-1.amazonaws.com/${firstImg['path_name']}";
          selectedIs360 = firstImg['is_3d'] ?? false;
        } else {
          selectedImage = '';
          selectedIs360 = false;
        }
        destinationName = user.businessName ?? "Business Name";
        district = user.district ?? "Business District";
        description =
            (user.businessDescription?.isNotEmpty == true)
                ? user.businessDescription!
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
    final imgProvider = Provider.of<ImgProvider>(context);

    // Preserve image data with its metadata (e.g., is_3d flag).
    final List<Map<String, dynamic>> imagesData =
        List<Map<String, dynamic>>.from(imgProvider.images);
    final List<String> imageUrls =
        imagesData.map<String>((img) {
          return img['url'] ??
              "https://goapp-assets.s3.eu-north-1.amazonaws.com/${img['path_name']}";
        }).toList();

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
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

              // Main Image Display:
              // If selected image is marked as 360°, show PanoramaViewer;
              // otherwise, display normally.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      selectedImage.isNotEmpty
                          ? (selectedIs360
                              ? PanoramaViewerWidget(imageUrl: selectedImage)
                              : Image.network(
                                selectedImage,
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ))
                          : Image.network(
                            "https://media.gettyimages.com/id/1473848096/vector/idyllic-landscape-with-footpath.jpg?s=612x612&w=gi&k=20&c=spGDcvw4FtlnWj3dqwgRgRKS_DMWOkBxXbHHtRYzTa8=",
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

              // Image Selector and Edit Button Row
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 1,
                ),
                child:
                    _isLoadingImage
                        ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ImageSelectorWidget(
                                images: imageUrls,
                                selectedImage: selectedImage,
                                onImageSelected: (img) {
                                  setState(() {
                                    selectedImage = img;
                                    // Find the corresponding image data to update the 360 flag.
                                    final found = imagesData.firstWhere(
                                      (item) =>
                                          (item['url'] ??
                                              "https://goapp-assets.s3.eu-north-1.amazonaws.com/${item['path_name']}") ==
                                          img,
                                      orElse: () => {},
                                    );
                                    selectedIs360 =
                                        (found['is_3d'] ?? false) as bool;
                                  });
                                },
                                onImageAdded: (imgPath) async {
                                  bool is360 = false;

                                  // Ask user if the image is 360°
                                  final shouldContinue = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title: Text(
                                              "Upload Image",
                                              style: AppTextStyles.bodyLarge
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: AppColors.darkGray,
                                                  ),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Do you want to mark this image as 360°?",
                                                  style: AppTextStyles
                                                      .bodyMedium
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                            AppColors
                                                                .mediumGray,
                                                      ),
                                                ),
                                                const SizedBox(height: 12),
                                                SwitchListTile(
                                                  title: Text(
                                                    "Mark as 360°",
                                                    style: AppTextStyles
                                                        .bodyMedium
                                                        .copyWith(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors
                                                                  .darkGray,
                                                        ),
                                                  ),
                                                  value: is360,
                                                  onChanged:
                                                      (val) => setState(
                                                        () => is360 = val,
                                                      ),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                ),
                                              ],
                                            ),
                                            actionsPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 8,
                                                ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.of(
                                                      ctx,
                                                    ).pop(false),
                                                child: Text(
                                                  "Cancel",
                                                  style: AppTextStyles
                                                      .bodyMedium
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed:
                                                    () => Navigator.of(
                                                      ctx,
                                                    ).pop(true),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.primary,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 12,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Upload",
                                                  style: AppTextStyles
                                                      .bodyMedium
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );

                                  if (shouldContinue != true) return;

                                  final success = await imgProvider.uploadImage(
                                    File(imgPath),
                                    userId!,
                                    is360: is360,
                                  );

                                  if (success) {
                                    setState(() => _isLoadingImage = true);
                                    await Future.delayed(
                                      const Duration(seconds: 4),
                                    );
                                    await imgProvider.fetchImages(userId!);
                                    setState(() => _isLoadingImage = false);

                                    if (imgProvider.images.isNotEmpty) {
                                      setState(() {
                                        final latest = imgProvider.images.last;
                                        selectedImage =
                                            latest['url'] ??
                                            "https://goapp-assets.s3.eu-north-1.amazonaws.com/${latest['path_name']}";
                                        selectedIs360 =
                                            latest['is_3d'] ?? false;
                                      });
                                    }
                                  } else {
                                    log(
                                      "Upload succeeded but image not returned properly.",
                                    );
                                  }
                                },

                                onImageRemoved: (imgUrl) async {
                                  final match = imgProvider.images.firstWhere(
                                    (element) =>
                                        imgUrl.endsWith(element['path_name']),
                                    orElse: () => {},
                                  );

                                  if (match.containsKey('id')) {
                                    setState(() => _isLoadingImage = true);
                                    final success = await imgProvider
                                        .deleteImages([match['id']]);

                                    if (success) {
                                      if (!imageUrls.contains(selectedImage)) {
                                        selectedImage =
                                            imageUrls.isNotEmpty
                                                ? imageUrls.first
                                                : '';
                                      }
                                    }
                                    setState(() => _isLoadingImage = false);
                                  }
                                },
                              ),
                            ),

                            IconButton(
                              icon: Icon(isEditing ? Icons.check : Icons.edit),
                              onPressed: () async {
                                if (!isEditing) {
                                  setState(() => isEditing = true);
                                  return;
                                }

                                final profileProvider =
                                    Provider.of<ProfileProvider>(
                                      context,
                                      listen: false,
                                    );

                                final success = await profileProvider
                                    .updateProfile(
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

              // Description Section
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
