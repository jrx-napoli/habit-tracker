import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final String? initialText;
  final TextEditingController? controller;

  const InputField(
      {super.key, required this.label, this.controller, this.initialText});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.dropShadowColor,
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 9),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGrey,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.lightGrey),
            hintText: label,
            labelText: initialText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ));
  }
}
