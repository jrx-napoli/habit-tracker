import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_colors.dart';
import 'nav_bar.dart';


class HomePage extends StatelessWidget {
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

              // Search bar with drop shadow
              const SizedBox(height: 25),
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

              // "Today" Section with Tabs
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
                    onPressed: () {}, // Add habit functionality
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
                  _CategoryTab(label: "Health", isSelected: true),
                  const SizedBox(width: 20),
                  _CategoryTab(label: "Literature", isSelected: false),
                ],
              ),
              const SizedBox(height: 25),

              // Habit Cards (Today Section)
              _HabitCard(
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
              _HabitCard(
                title: "Read",
                category: "Literature",
                streak: "13 days streak",
                progress: 0,
                goal: 1,
                status: "Pending",
                colorA: AppColors.purpleA,
                colorB: AppColors.purpleB,
              ),

              const SizedBox(height: 24),

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
              const SizedBox(height: 16),

              // Habit Cards (This Week Section)
              _HabitCard(
                title: "Practice piano",
                category: "Music",
                streak: "7 weeks streak",
                progress: 1,
                goal: 1,
                status: "Done",
                colorA: AppColors.pinkA,
                colorB: AppColors.pinkB,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),


      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0,
        // onTap: (index) {
        //   setState(() {
        //     currentIndex = index; // Update the selected index
        //   });
        // },
      ),
    );
  }
}

// Widget for Category Tabs
class _CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryTab({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.darkGrey : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.dropShadowColor,
            spreadRadius: 0, // How far the shadow spreads
            blurRadius: 20, // Softness of the shadow
            offset: Offset(0, 9), // Position of the shadow (horizontal, vertical)
          ),
        ]
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.lightGrey,
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Widget for Habit Cards
class _HabitCard extends StatelessWidget {
  final String title;
  final String category;
  final String streak;
  final double progress;
  final int goal;
  final String status;
  final Color colorA;
  final Color colorB;

  const _HabitCard({
    required this.title,
    required this.category,
    required this.streak,
    required this.progress,
    required this.goal,
    required this.status,
    required this.colorA,
    required this.colorB,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorA, colorB],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Habit title and category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              HeartIcon(
                color: colorB.withAlpha(255),
              ),
            ],
          ),
          Text(
            category,
            style: TextStyle(
              color: AppColors.darkGrey.withAlpha(150),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Streak and Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FlameIcon(),
                  SizedBox(width: 8), // 20 pixels of space
                  Text(
                    streak,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress / goal,
            backgroundColor: Colors.white38,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}

class FlameIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/flame_icon.svg',
        width: 18,  // Set icon size
        height: 22,
        color: Colors.white, // Optional: Tint the icon
      ),
    );
  }
}

class HeartIcon extends StatelessWidget {
    final Color color;

  const HeartIcon({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/heart_icon.svg',
        width: 24,  // Set icon size
        height: 24,
        color: color, // Optional: Tint the icon
      ),
    );
  }
}
