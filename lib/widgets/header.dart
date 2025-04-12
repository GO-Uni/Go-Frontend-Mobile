import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

enum HeaderVariant { searchHeader, compactHeader }

class Header extends StatelessWidget {
  final Function(int) onTabSelected;
  final HeaderVariant variant;
  final int? initialTabIndex;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final Function(Map<String, dynamic>)? onDestinationTap;

  const Header({
    super.key,
    required this.onTabSelected,
    this.variant = HeaderVariant.compactHeader,
    this.initialTabIndex,
    this.searchController,
    this.onSearchChanged,
    this.onDestinationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 22),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (variant == HeaderVariant.searchHeader) ...[
            searchHeader,
            tabBar,
          ] else ...[
            compactHeader,
          ],
        ],
      ),
    );
  }

  Widget get searchHeader => Container(
    margin: const EdgeInsets.only(top: 14),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Text(
          "GO",
          style: AppTextStyles.boldText.copyWith(
            fontSize: 34,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
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
                    controller: searchController,
                    onChanged: onSearchChanged,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "Discover places...",
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightGray,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.search, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget get compactHeader => Container(
    padding: const EdgeInsets.only(right: 18, left: 18, top: 12, bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "GO",
          style: AppTextStyles.boldText.copyWith(
            fontSize: 28,
            color: AppColors.primary,
          ),
        ),
        Text(
          "Discover Lebanon with GO",
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: 14,
            color: AppColors.darkGray,
          ),
        ),
      ],
    ),
  );

  Widget get tabBar => Center(
    child: SizedBox(
      width: 250,
      child: DefaultTabController(
        length: 2,
        initialIndex: initialTabIndex ?? 0,
        child: TabBar(
          onTap: (index) => onTabSelected(index),
          indicator:
              initialTabIndex == null
                  ? const BoxDecoration()
                  : const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2, color: AppColors.primary),
                    insets: EdgeInsets.symmetric(horizontal: 120),
                  ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
          unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
          labelColor: AppColors.darkGray,
          unselectedLabelColor: AppColors.darkGray,
          dividerColor: AppColors.lightGreen,
          dividerHeight: 3.0,
          tabs: const [Tab(text: "Destinations"), Tab(text: "Saved")],
        ),
      ),
    ),
  );
}
