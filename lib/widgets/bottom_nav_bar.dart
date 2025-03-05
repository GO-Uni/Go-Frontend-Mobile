import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../services/routes.dart';
import '../theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  BottomNavigationBarItem _buildBottomNavItem({
    required String iconPath,
    required int index,
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.10 * 255).toInt()),
                offset: const Offset(0, -6),
                blurRadius: 16,
                spreadRadius: 4,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            iconSize: 35,
            currentIndex: selectedIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.darkGray,
            onTap: onTap,
            items: [
              _buildBottomNavItem(iconPath: 'assets/icons/map.png', index: 0),
              _buildBottomNavItem(iconPath: 'assets/icons/bot.png', index: 1),
              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              _buildBottomNavItem(
                iconPath: 'assets/icons/calendar.png',
                index: 3,
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
    );
  }
}
