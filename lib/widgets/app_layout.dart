import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/routes.dart';
import 'header.dart';
import 'bottom_nav_bar.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int? _selectedTabIndex;
  Key _headerKey = UniqueKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra is int) {
      setState(() {
        _selectedTabIndex = extra;
      });
    }
  }

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
    setState(() {
      _headerKey = UniqueKey();
      _selectedTabIndex = null;
    });
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
    int selectedIndex = _getBottomNavIndex(context);
    bool needsSearchHeader = _needsSearchHeader(context);

    return Scaffold(
      body: Column(
        children: [
          Header(
            key: _headerKey,
            onTabSelected: _onHeaderTabSelected,
            variant:
                needsSearchHeader
                    ? HeaderVariant.searchHeader
                    : HeaderVariant.compactHeader,
            initialTabIndex: _selectedTabIndex,
          ),
          Expanded(child: widget.child),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
