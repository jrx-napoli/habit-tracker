import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';
import '../habit_form/edit_habit_form.dart';


// Widget for Habit Cards
class HabitCard extends StatelessWidget {
  final String title;
  final String category;
  final String streak;
  final double progress;
  final int goal;
  final String status;
  final Color colorA;
  final Color colorB;

  const HabitCard({
    super.key, 
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
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Allows the modal to expand fully
          backgroundColor: Colors.transparent, 
          barrierColor: Colors.transparent,// Makes the modal background transparent
          builder: (context) {
            return EditHabitForm();
          },
        );
      },

      child: Container(
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
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 9), // (horizontal, vertical)
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
            
            // Progress bar
            LinearProgressIndicator(
              value: progress / goal,
              backgroundColor: Colors.white38,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FlameIcon extends StatelessWidget {
  const FlameIcon({super.key});

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
    super.key, 
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
