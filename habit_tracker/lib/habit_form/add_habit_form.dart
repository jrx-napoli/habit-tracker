import 'dart:ui'; // Required for the blur effect
import 'package:flutter/material.dart';

import 'package:habit_tracker/constants/app_colors.dart';
import 'input_field.dart';
import 'frequency_field.dart';
import 'target_field.dart';
import 'notifications_field.dart';
import 'notes_field.dart';


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
                              InputField(label: "Activity"),
                              SizedBox(height: 10),
                              InputField(label: "Category"),
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
                              FrequencyField(),
                              SizedBox(height: 10),
                              TargetField(),
                              SizedBox(height: 10),
                              NotificationsField(),
                            ],
                          )
                        ),
                        SizedBox(height: 20),
                        NotesField(),
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
}
