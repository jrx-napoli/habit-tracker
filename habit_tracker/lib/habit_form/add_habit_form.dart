import 'dart:ui'; // Required for the blur effect
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/habit_form/frequency_field.dart';
import 'package:habit_tracker/habit_form/notifications_field.dart';
import 'package:habit_tracker/habit_form/target_field.dart';
import 'input_field.dart';
import 'notes_field.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddHabitForm extends StatefulWidget {
  const AddHabitForm({super.key});

  @override
  State<AddHabitForm> createState() => _AddHabitFormState();
}

class _AddHabitFormState extends State<AddHabitForm> {
  String selectedFrequency = "Daily"; // Default frequency value
  String selectedTarget = "Complete"; // Default target value
  int? reachCount; // Store the numerical value for "Reach Count"

  final TextEditingController activityController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController reachCountController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addHabit(Map<String, dynamic> habitData) async {
    try {
      // Get the current user's UID
      final User? user = auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Add the habit to the user's habits collection
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .add(habitData);
      print("Habit added successfully!");
    } catch (e) {
      print("Error adding habit: $e");
    }
  }

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
                        "New",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGrey,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Collect data from input fields
                          final habitData = {
                            "activity": activityController.text,
                            "category": categoryController.text,
                            "frequency": selectedFrequency,
                            "targetType": selectedTarget,
                            "reachCount": selectedTarget == "Reach count"
                                ? int.tryParse(reachCountController.text) ?? 0
                                : null,
                            "notes": notesController.text,
                            "progress": 0,
                            "goal": selectedTarget == "Complete"
                                ? 1
                                : int.parse(reachCountController.text),
                            "createdAt": FieldValue.serverTimestamp(),
                            "isFavorite": false,
                            "streak": 0,
                            "status": "Pending"
                          };

                          // Save the habit to Firestore
                          await addHabit(habitData);

                          // Close the modal
                          Navigator.pop(context, true); // Close the modal
                        },
                        child: Text(
                          "Add",
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
                              InputField(
                                label: "Activity",
                                controller: activityController,
                              ),
                              const SizedBox(height: 10),
                              InputField(
                                label: "Category",
                                controller: categoryController,
                              ),
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
                                    InputField(
                                      label: "Count",
                                      controller: reachCountController,
                                    )
                                  ],
                                ),

                              const SizedBox(height: 10),

                              NotificationsField()
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Notes Field
                        NotesField(
                          controller: notesController,
                        ),
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
