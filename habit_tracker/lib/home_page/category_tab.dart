import 'package:flutter/material.dart';

import '../constants/app_colors.dart';


class CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryTab({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.darkGrey : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.dropShadowColor,
            spreadRadius: 0,
            blurRadius: 20, 
            offset: Offset(0, 9), // (horizontal, vertical)
          ),
        ]
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.lightGrey,
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
