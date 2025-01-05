import 'package:flutter/material.dart';
import 'home_page/home_page.dart';
import 'nav_bar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int currentIndex = 0; // index of current page 

  // Pages for each tab
  final List<Widget> pages = [
    Center(child: HomePage()),
    Center(child: Text('Explore Page')),
    Center(child: Text('Activity Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },  
        ),
      ),
    );
  }
}
