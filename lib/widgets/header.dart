import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class Header extends StatelessWidget {
  final TabController tabController;

  const Header({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
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
                const SizedBox(width: 4),
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
                          onPressed: () {},
                          icon: const Icon(Icons.search, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: TabBar(
                controller: tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2, color: AppColors.primary),
                  insets: EdgeInsets.symmetric(horizontal: 120),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                ),
                labelColor: AppColors.darkGray,
                unselectedLabelColor: AppColors.darkGray,
                dividerColor: AppColors.lightGreen,
                dividerHeight: 3.0,
                tabs: const [Tab(text: "Destinations"), Tab(text: "Saved")],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
