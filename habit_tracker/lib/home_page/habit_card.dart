import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';
import '../habit_form/edit_habit_form.dart';

class HabitCard extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String streak;
  final int progress;
  final int goal;
  final String status;
  final Color colorA;
  final Color colorB;
  final void Function(int change) onProgressChange;
  final bool isFavorite; // Added property to indicate favorite state
  final VoidCallback onFavoriteToggle; // Added callback for toggling favorite

  const HabitCard({
    super.key,
    required this.id,
    required this.title,
    required this.category,
    required this.streak,
    required this.progress,
    required this.goal,
    required this.status,
    required this.colorA,
    required this.colorB,
    required this.onProgressChange,
    required this.isFavorite, // Initialize isFavorite
    required this.onFavoriteToggle, // Initialize onFavoriteToggle
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(title),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swiped right -> Decrease progress
              onProgressChange(-1);
            } else if (direction == DismissDirection.endToStart) {
              // Swiped left -> Increase progress
              onProgressChange(1);
            }
            // Return false to prevent full dismissal
            return false;
          },
          background: Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                color: colorA.withAlpha(200)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Icon(Icons.remove,
                color: Colors.white, size: 32), // Icon for swipe right
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),
              color: colorB.withAlpha(200),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.add,
                color: Colors.white, size: 32), // Icon for swipe left
          ),
          child: GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Allows the modal to expand fully
                backgroundColor: Colors.transparent,
                barrierColor: Colors
                    .transparent, // Makes the modal background transparent
                builder: (context) {
                  return EditHabitForm(
                    habitId: id,
                    title: title,
                    category: category,
                  );
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
                // borderRadius: BorderRadius.circular(20),
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
                      GestureDetector(
                        onTap: onFavoriteToggle, // Handle tap
                        child: HeartIcon(
                          isFilled:
                              isFavorite, // Update based on favorite state
                          color: colorB.withAlpha(255),
                        ),
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
          ),
        ));
  }
}

class FlameIcon extends StatelessWidget {
  const FlameIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/flame_icon.svg',
        width: 18,
        height: 22,
        color: Colors.white,
      ),
    );
  }
}

class HeartIcon extends StatelessWidget {
  final bool isFilled; // Added property to determine filled or outlined
  final Color color;

  const HeartIcon({
    super.key,
    required this.isFilled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        // isFilled
        //     ? 'assets/icons/heart_filled_icon.svg'
        //     : 'assets/icons/heart_icon.svg',
        'assets/icons/heart_icon.svg',
        width: 24,
        height: 24,
        color: color,
      ),
    );
  }
}
