import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'habit_card.dart';
import 'category_tab.dart';
import '../habit_form/add_habit_form.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> habits = []; // List to store habits

  @override
  void initState() {
    super.initState();
    fetchHabits(); // Fetch habits when the widget is initialized
  }

  Future<void> fetchHabits() async {
    try {
      final User? user = auth.currentUser; // Get the logged-in user
      if (user == null) throw Exception("User not logged in");

      // Reference to the user's habits collection
      final habitsSnapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .get();

      // Convert the fetched documents into a list of maps
      final fetchedHabits = habitsSnapshot.docs
          .map((doc) => {
                'id': doc.id, // Include the document ID
                ...doc.data(), // Include all other data
              })
          .toList();

      // Update the state with the fetched habits
      setState(() {
        habits = fetchedHabits;
      });

      print("Habits fetched: $habits");
    } catch (e) {
      print("Error fetching habits: $e");
    }
  }

  String selectedCategory = "All"; // Track the selected category

  void updateProgress(int index, int change) {
    setState(() {
      final newProgress = habits[index]['progress'] + change;

      // Ensure progress stays within valid bounds
      if (newProgress >= 0 && newProgress <= habits[index]['goal']) {
        habits[index]['progress'] = newProgress;
        String status = "";
        // Update the displayed status
        if (newProgress == habits[index]['goal']) {
          status = "Done";
          habits[index]['status'] = "Done";
        } else if (newProgress == 0) {
          status = "Pending";
          habits[index]['status'] = "Pending";
        } else {
          status = "$newProgress/${habits[index]['goal']}";
          habits[index]['status'] = "$newProgress/${habits[index]['goal']}";
        }

        updateHabit(habits[index]['id'], newProgress, status);
      }
    });
  }

  Future<void> updateHabit(
      String habitId, int newProgress, String status) async {
    try {
      final User? user = auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Update the progress field
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('habits')
          .doc(habitId)
          .update({"progress": newProgress, "status": status});

      print("Habit updated successfully!");
    } catch (e) {
      print("Error updating habit: $e");
    }
  }

  List<String> getCategories() {
    // Extract unique categories from the habits list
    final categories =
        habits.map((habit) => habit['category'] as String).toSet().toList();
    categories.sort(); // Sort alphabetically
    return ["All", ...categories]; // Add "All" as a default category
  }

  List<Map<String, dynamic>> getFilteredHabits() {
    // Filter habits based on the selected category
    if (selectedCategory == "All") {
      return habits;
    }
    return habits
        .where((habit) => habit['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = getCategories();
    final filteredHabits = getFilteredHabits();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Removes the default app bar space
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                    offset: Offset(
                        0, 9), // Position of the shadow (horizontal, vertical)
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
                      color: AppColors.lightGrey),
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
                  "Hello, Jan",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey),
                ),
                TextButton(
                  onPressed: () async {
                    final shouldRefresh = showModalBottomSheet<bool>(
                      context: context,
                      isScrollControlled:
                          true, // Allows the modal to expand fully
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      builder: (context) {
                        return AddHabitForm();
                      },
                    );

                    if (shouldRefresh == true) {
                      setState(() {
                        fetchHabits();
                      });
                    }
                  }, // Add habit functionality
                  child: Text(
                    "Add habit",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightGrey),
                  ),
                ),
              ],
            ),

            // Scrollable category tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CategoryTab(
                      label: category,
                      isSelected: category == selectedCategory,
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            // Habit cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredHabits.length,
                itemBuilder: (context, index) {
                  final habit = filteredHabits[index];

                  return Column(
                    children: [
                      HabitCard(
                        id: habit['id'],
                        title: habit['activity'],
                        category: habit['category'],
                        streak: habit['streak'].toString(),
                        progress: habit['progress'],
                        goal: habit['goal'],
                        status: "${habit['progress']}/${habit['goal']}",
                        colorA: AppColors.gradients[(2 * index) % 6],
                        colorB: AppColors.gradients[(2 * index + 1) % 6],
                        onProgressChange: (change) =>
                            updateProgress(index, change),
                        isFavorite: habit['isFavorite'],
                        onFavoriteToggle: () {
                          setState(() {
                            habit['isFavorite'] = !habit['isFavorite'];
                          });
                        },
                      ),
                      SizedBox(height: 16)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
