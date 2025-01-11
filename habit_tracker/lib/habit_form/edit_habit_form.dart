import 'dart:ui'; // Required for the blur effect
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/habit_form/delete_button.dart';
import 'package:habit_tracker/habit_form/frequency_field.dart';
import 'package:habit_tracker/habit_form/notifications_field.dart';
import 'package:habit_tracker/habit_form/target_field.dart';
import 'input_field.dart';
import 'notes_field.dart';

class EditHabitForm extends StatefulWidget {
  const EditHabitForm({super.key});

  @override
  State<EditHabitForm> createState() => _EditHabitFormState();
}

class _EditHabitFormState extends State<EditHabitForm> {
  String selectedFrequency = "Daily"; // Default frequency value
  String selectedTarget = "Complete"; // Default target value
  int? reachCount; // Store the numerical value for "Reach Count"

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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
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
                        onPressed: () =>
                            Navigator.of(context).pop(), // Close the modal
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGrey,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add habit logic here
                          Navigator.of(context).pop(); // Close the modal
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Form Fields
                  Expanded(
                    child: ListView(
                      controller: scrollController, // Makes the form scrollable
                      children: [
                        // Activity and Category Fields
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              InputField(label: "Activity"),
                              const SizedBox(height: 10),
                              InputField(label: "Category"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Frequency and Target Dropdown Fields
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              // Frequency Dropdown
                              FrequencyField(
                                  selectedFrequency: selectedFrequency,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFrequency = value;
                                    });
                                  }),

                              const SizedBox(height: 10),

                              // Target Dropdown
                              TargetField(
                                  selectedTarget: selectedTarget,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTarget = value;
                                    });
                                  }),

                              // Reach Count Input (Visible only when "Reach Count" is selected)
                              if (selectedTarget == "Reach count")
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    InputField(label: "Count")
                                  ],
                                ),

                              const SizedBox(height: 10),

                              NotificationsField()
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Notes Field
                        NotesField(),

                        const SizedBox(height: 20),

                        DeleteButton()
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
