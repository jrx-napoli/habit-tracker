import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function when the tab is tapped
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          boxShadow: [
            // BoxShadow(
            //   color: AppColors.dropShadowColor,
            //   spreadRadius: 0,
            //   blurRadius: 20,
            //   offset: Offset(0, 9), // (horizontal, vertical)
            // ),
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
