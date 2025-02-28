import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../services/routes.dart';
import '../theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  final Widget child;
  const BottomNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = _getCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              iconSize: 35,
              currentIndex: selectedIndex,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.darkGray,
              onTap: (index) {
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
              },
              items: [
                _buildBottomNavItem(
                  iconPath: 'assets/icons/map.png',
                  index: 0,
                  selectedIndex: selectedIndex,
                ),

                _buildBottomNavItem(
                  iconPath: 'assets/icons/bot.png',
                  index: 1,
                  selectedIndex: selectedIndex,
                ),

                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),

                _buildBottomNavItem(
                  iconPath: 'assets/icons/calendar.png',
                  index: 3,
                  selectedIndex: selectedIndex,
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color:
                        selectedIndex == 4
                            ? AppColors.primary
                            : AppColors.darkGray,
                  ),
                  label: '',
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 35,
            child: GestureDetector(
              onTap: () => context.go(ConfigRoutes.whereToNext),
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/location-logo.svg',
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required String iconPath,
    required int index,
    required int selectedIndex,
  }) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 35,
        height: 35,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            index == selectedIndex ? AppColors.primary : AppColors.darkGray,
            BlendMode.srcATop,
          ),
          child: Image.asset(iconPath, fit: BoxFit.contain),
        ),
      ),
      label: '',
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == ConfigRoutes.chatbot) return 1;
    if (location == ConfigRoutes.whereToNext) return 2;
    if (location == ConfigRoutes.bookings) return 3;
    if (location == ConfigRoutes.profile) return 4;
    return 0;
  }
}
