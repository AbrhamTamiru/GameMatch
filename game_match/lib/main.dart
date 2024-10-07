import 'package:flutter/material.dart';
import 'pages/Profile.dart'; // Import the profile page
import 'pages/Side_bar.dart'; // Import the side bar page

void main() {
  runApp(const GameMatchApp());
}

class GameMatchApp extends StatelessWidget {
  const GameMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameMatch', // The title of your app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SideBar(), // This is the side bar page
      routes: {
        '/side_bar': (context) => const SideBar(), // This is the side bar page
        '/Profile': (context) => const Profile(), // This is the profile page
      },
      //home: const HomePage(), // This is the main screen of your app
    );
  }
}
