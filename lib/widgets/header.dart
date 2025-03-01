import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import 'package:go_router/go_router.dart';
import '../services/routes.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(
                "GO",
                style: AppTextStyles.boldText.copyWith(
                  fontSize: 34,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: "Discover places...",
                            hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.lightGray,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          // Add search functionality
                        },
                        icon: const Icon(Icons.search, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("Destinations", 0, ConfigRoutes.destinations),
                  _buildTabButton("Saved", 1, ConfigRoutes.saved),
                ],
              ),
              const SizedBox(height: 4),

              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 2,
                      width: 250,
                      color: AppColors.lightGreen,
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left:
                          selectedIndex == 0
                              ? 0
                              : selectedIndex == 1
                              ? 160
                              : -100,
                      child: Container(
                        height: 2,
                        width: selectedIndex == -1 ? 0 : 120,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, int index, String route) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        context.go(route);
      },
      child: Column(
        children: [
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 16,
              color:
                  selectedIndex == index
                      ? AppColors.darkGray
                      : AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }
}
