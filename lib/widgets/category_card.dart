import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import '../services/routes.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<DestinationProvider>().fetchDestinationsByCategory(
          title,
        );

        if (!context.mounted) return;

        context.go(ConfigRoutes.destinations, extra: {"category": title});
      },
      child: Column(
        children: [
          SizedBox(
            height: 140,
            width: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkGray),
          ),
        ],
      ),
    );
  }
}
