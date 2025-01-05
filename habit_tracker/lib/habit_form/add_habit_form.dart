import 'dart:ui'; // Required for the blur effect
import 'package:flutter/material.dart';

import 'package:habit_tracker/constants/app_colors.dart';

class AddHabitForm extends StatelessWidget {
  const AddHabitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9, // Expandable up to 90%
      minChildSize: 0.7, // Minimum height at 70%
      builder: (context, scrollController) {
        return Stack(
          children: [
            
            // Background blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(),
            ),
            
            // Habit creation form container
            Container(
              decoration: BoxDecoration(
                color: AppColors.semiTransparentBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // Header with Cancel and Add buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(), // Close the modal
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: AppColors.red, 
                            fontSize: 16),
                        ),
                      ),
                      Text(
                        "New",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGrey, 
                            fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add habit logic here
                          Navigator.of(context).pop(); // Close the modal
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Colors.blue, 
                            fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Form Fields
                  Expanded(
                    child: ListView(
                      controller: scrollController, // Makes the form scrollable
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              _buildInputField("Activity"),
                              SizedBox(height: 10),
                              _buildInputField("Category"),
                            ],
                          )
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              _buildFrequencyField(),
                              SizedBox(height: 10),
                              _buildTargetField(),
                              SizedBox(height: 10),
                              _buildNotificationsField(),
                            ],
                          )
                        ),
                        SizedBox(height: 20),
                        _buildNotesField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(String label) {
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
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lightGrey
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      )
    ); 
  }

  Widget _buildFrequencyField() {
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
              "Frequency",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Daily',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500),
            ),
          ),
        ],
      )
    ); 
  }

  Widget _buildTargetField() {
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
              "Target",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Reach count',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],  
          ),
        ],
      )
    ); 
  }

  Widget _buildNotificationsField() {
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

  Widget _buildNotesField() {
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
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lightGrey
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          labelText: 'Notes',
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      )
    );
  }
}
