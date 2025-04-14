import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/colors.dart';

class ImageSelectorWidget extends StatelessWidget {
  final List<String> images;
  final String selectedImage;
  final Function(String) onImageSelected;
  final Function(String) onImageAdded;

  const ImageSelectorWidget({
    super.key,
    required this.images,
    required this.selectedImage,
    required this.onImageSelected,
    required this.onImageAdded,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      onImageAdded(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == images.length) {
            return GestureDetector(
              onTap: () => _pickImage(context),
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightGray.withAlpha(77),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.add, color: AppColors.darkGreen),
              ),
            );
          }

          final image = images[index];
          final isSelected = selectedImage == image;

          return GestureDetector(
            onTap: () => onImageSelected(image),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      image,
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
    );
  }
}
