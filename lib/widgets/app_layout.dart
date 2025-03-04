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
  Widget? _selectedHeaderContent;
  Key _headerKey = UniqueKey();

  void _onHeaderTabSelected(int index) {
    switch (index) {
      case 0:
        context.go(ConfigRoutes.destinations);
        break;
      case 1:
        context.go(ConfigRoutes.saved);
        break;
      default:
        _selectedHeaderContent = null;
    }
  }

  void _resetHeader() {
    setState(() {
      _headerKey = UniqueKey();
      _selectedHeaderContent = null;
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

  bool _isCompactHeader(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location == ConfigRoutes.chatbot ||
        location == ConfigRoutes.whereToNext;
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
    bool isCompact = _isCompactHeader(context);

    return Scaffold(
      body: Column(
        children: [
          Header(
            key: _headerKey,
            onTabSelected: _onHeaderTabSelected,
            variant:
                isCompact
                    ? HeaderVariant.compactHeader
                    : HeaderVariant.defaultHeader,
          ),
          Expanded(child: _selectedHeaderContent ?? widget.child),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
