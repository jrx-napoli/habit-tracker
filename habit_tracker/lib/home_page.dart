import 'package:flutter/material.dart';
import 'app_colors.dart';


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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                progress: 0.375, //
                colorA: AppColors.blueA,
                colorB: AppColors.blueB,
              ),
              const SizedBox(height: 16),
              _HabitCard(
                title: "Read",
                category: "Literature",
                streak: "13 days streak",
                progress: 0.5, // 4/8
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
                progress: 1.0, // Done
                colorA: AppColors.pinkA,
                colorB: AppColors.pinkB,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: 0, // Home is selected
        onTap: (index) {
          // Handle navigation
        },
        type: BottomNavigationBarType.fixed,
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
  final Color colorA;
  final Color colorB;

  const _HabitCard({
    required this.title,
    required this.category,
    required this.streak,
    required this.progress,
    required this.colorA,
    required this.colorB,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
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
              Icon(Icons.local_fire_department, color: Colors.white),
              Text(
                streak,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${(progress * 8).toInt()}/8",
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
            value: progress,
            backgroundColor: Colors.white38,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
