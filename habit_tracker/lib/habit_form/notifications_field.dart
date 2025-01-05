import 'package:flutter/material.dart';

import '../constants/app_colors.dart';


class NotificationsField extends StatelessWidget {

  const NotificationsField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.dropShadowColor,
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              "Notifications",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey
              ),
            ),
          ),
          Switch(value: false, onChanged: (value) {}),
        ],
      )
    ); 
  }
}
