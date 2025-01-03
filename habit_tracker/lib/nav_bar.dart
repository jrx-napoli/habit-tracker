import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  // final Function(int) onTap;

  const CustomNavigationBar({
    required this.currentIndex,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define your icons here
    final List<Map<String, dynamic>> navItems = [
      {"icon": "assets/icons/home_icon.svg", "label": "Home"},
      {"icon": "assets/icons/globe_icon.svg", "label": "Explore"},
      {"icon": "assets/icons/activity_icon.svg", "label": "Activity"},
      {"icon": "assets/icons/user_icon.svg", "label": "Profile"},
    ];

    return BottomAppBar(
      color: Colors.white, // Background color of the navigation bar
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(navItems.length, (index) {
            final isActive = index == currentIndex;

            return GestureDetector(
              // onTap: () => onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Custom SVG Icon
                  SvgPicture.asset(
                    navItems[index]["icon"],
                    height: 28,
                    color: isActive ? Colors.black : Colors.grey,
                  ),
                  // Red dot below the active icon
                  if (isActive)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          }),

          
        ),
      ),
    );
  }
}
