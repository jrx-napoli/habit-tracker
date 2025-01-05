import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'habit_card.dart';
import 'category_tab.dart';
import '../habit_form/add_habit_form.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Removes the default app bar space
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 25),

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dropShadowColor,
                      spreadRadius: 0, // How far the shadow spreads
                      blurRadius: 20, // Softness of the shadow
                      offset: Offset(0, 9), // Position of the shadow (horizontal, vertical)
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGrey
                    ),
                    prefixIcon: Icon(Icons.search, color: AppColors.lightGrey),
                    filled: true,
                    fillColor: Colors.white, // Match the container's background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25),

              // "Today" Section with category tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Allows the modal to expand fully
                        backgroundColor: Colors.transparent, 
                        barrierColor: Colors.transparent,// Makes the modal background transparent
                        builder: (context) {
                          return AddHabitForm();
                        },
                      );
                    }, // Add habit functionality
                    child: Text(
                      "Add habit",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightGrey
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CategoryTab(label: "Health", isSelected: true),
                  const SizedBox(width: 20),
                  CategoryTab(label: "Literature", isSelected: false),
                ],
              ),

              const SizedBox(height: 25),

              // Habit Cards (Today Section)
              HabitCard(
                title: "Drink water",
                category: "Health",
                streak: "21 days streak",
                progress: 3, //
                goal: 8,
                status: "3/8",
                colorA: AppColors.blueA,
                colorB: AppColors.blueB,
              ),
              const SizedBox(height: 16),
              HabitCard(
                title: "Read",
                category: "Literature",
                streak: "13 days streak",
                progress: 0,
                goal: 1,
                status: "Pending",
                colorA: AppColors.purpleA,
                colorB: AppColors.purpleB,
              ),

              const SizedBox(height: 25),

              // "This Week" Section
              Text(
                "This week",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey
                ),
              ),

              const SizedBox(height: 25),

              // Habit Cards (This Week Section)
              HabitCard(
                title: "Practice piano",
                category: "Music",
                streak: "7 weeks streak",
                progress: 1,
                goal: 1,
                status: "Done",
                colorA: AppColors.pinkA,
                colorB: AppColors.pinkB,
              ),
              
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
