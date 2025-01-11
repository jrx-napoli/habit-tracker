import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';

class TargetField extends StatelessWidget {
  final String selectedTarget;
  final ValueChanged<String> onChanged;

  const TargetField({
    super.key,
    required this.selectedTarget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.dropShadowColor,
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGrey,
        ),
        value: selectedTarget,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          labelText: null,
          border: InputBorder.none,
        ),
        items: ["Complete", "Reach count"]
            .map((target) => DropdownMenuItem(
                  value: target,
                  child: Text(target),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
