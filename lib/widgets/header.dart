import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class Header extends StatefulWidget {
  final Function(int) onTabSelected;

  const Header({super.key, required this.onTabSelected});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedIndex = null;

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
        widget.onTabSelected(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),

      child: Container(
        padding: const EdgeInsets.only(top: 23),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
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
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onTabSelected(index);
                  },
                  indicator:
                      _selectedIndex == null
                          ? const BoxDecoration()
                          : const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 2,
                              color: AppColors.primary,
                            ),
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
      ),
    );
  }
}
