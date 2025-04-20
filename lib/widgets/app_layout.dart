import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../services/routes.dart';
import 'header.dart';
import 'bottom_nav_bar.dart';
import '../providers/destination_provider.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int? _selectedTabIndex;
  Key _headerKey = UniqueKey();
  final TextEditingController _searchController = TextEditingController();

  void _onHeaderTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });

    switch (index) {
      case 0:
        context.go(ConfigRoutes.destinations, extra: 0);
        break;
      case 1:
        context.go(ConfigRoutes.saved, extra: 1);
        break;
    }
  }

  void _resetHeader() {
    _searchController.clear();
    final provider = Provider.of<DestinationProvider>(context, listen: false);
    provider.clearSearchResults();
    setState(() {
      _headerKey = UniqueKey();
      _selectedTabIndex = null;
    });
  }

  void _onSearchChanged(String value) async {
    final provider = Provider.of<DestinationProvider>(context, listen: false);
    if (value.trim().isEmpty) {
      provider.clearSearchResults();
    } else {
      await provider.fetchDestinationsByName(value.trim());
    }
  }

  void _onDestinationTap(Map<String, dynamic> destination) {
    _resetHeader();
    context.go(
      ConfigRoutes.detailedDestination,
      extra: {
        "imageUrl": destination["main_img"],
        "name": destination["business_name"],
        "description": destination["description"],
        "rating": destination["rating"],
        "district": destination["district"],
        "userid": destination["user_id"],
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra is Map<String, dynamic> && extra.containsKey("tabIndex")) {
      final int newIndex = extra["tabIndex"];
      if (newIndex != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = newIndex;
        });
      }
    }
  }

  int _getBottomNavIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == ConfigRoutes.chatbot) return 1;
    if (location == ConfigRoutes.whereToNext) return 2;
    if (location == ConfigRoutes.bookings) return 3;
    if (location == ConfigRoutes.profile) return 4;
    return 0;
  }

  bool _needsSearchHeader(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location == ConfigRoutes.destinations ||
        location == ConfigRoutes.saved ||
        location == ConfigRoutes.bookings;
  }

  void _onBottomNavTap(int index) {
    _resetHeader();
    switch (index) {
      case 0:
        context.go(ConfigRoutes.maps);
        break;
      case 1:
        context.go(ConfigRoutes.chatbot);
        break;
      case 2:
        context.go(ConfigRoutes.whereToNext);
        break;
      case 3:
        context.go(ConfigRoutes.bookings);
        break;
      case 4:
        context.go(ConfigRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinationProvider = Provider.of<DestinationProvider>(context);
    int selectedIndex = _getBottomNavIndex(context);
    bool needsSearchHeader = _needsSearchHeader(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                key: _headerKey,
                onTabSelected: _onHeaderTabSelected,
                variant:
                    needsSearchHeader
                        ? HeaderVariant.searchHeader
                        : HeaderVariant.compactHeader,
                initialTabIndex: _selectedTabIndex,
                searchController: needsSearchHeader ? _searchController : null,
                onSearchChanged: needsSearchHeader ? _onSearchChanged : null,
                onDestinationTap: needsSearchHeader ? _onDestinationTap : null,
              ),
              Expanded(child: widget.child),
            ],
          ),

          if (needsSearchHeader &&
              destinationProvider.searchDestinations.isNotEmpty)
            Positioned(
              top: 90,
              left: 56,
              right: 16,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      destinationProvider.searchDestinations.length * 2 - 1,
                      (index) {
                        if (index.isOdd) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 12,
                            endIndent: 12,
                            color: AppColors.darkGreen,
                          );
                        }

                        final destIndex = index ~/ 2;
                        final dest =
                            destinationProvider.searchDestinations[destIndex];

                        return ListTile(
                          title: Text(
                            dest['business_name'] ?? '',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontSize: 16,
                              color: AppColors.darkGray,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            dest['district'] ?? '',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 13,
                              color: AppColors.lightGray,
                            ),
                          ),
                          onTap: () => _onDestinationTap(dest),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
