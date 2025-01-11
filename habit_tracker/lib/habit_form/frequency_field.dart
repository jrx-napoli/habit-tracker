import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';

class FrequencyField extends StatelessWidget {
  final String selectedFrequency;
  final ValueChanged<String> onChanged;

  const FrequencyField({
    super.key,
    required this.selectedFrequency,
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
        value: selectedFrequency,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          labelText: null,
          border: InputBorder.none,
        ),
        items: ["Daily", "Weekly", "Monthly"]
            .map((freq) => DropdownMenuItem(
                  value: freq,
                  child: Text(freq),
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
