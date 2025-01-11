import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class NotesField extends StatelessWidget {
  const NotesField({super.key});

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
          maxLines: 5,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGrey,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.lightGrey),
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            hintText: 'Notes',
            alignLabelWithHint: true,
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
