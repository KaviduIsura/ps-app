import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart'; // Import the LoadingScreen

void main() {
  runApp(const GreenControlApp());
}

class GreenControlApp extends StatelessWidget {
  const GreenControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenControl',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
      ),
      home: const LoadingScreen(), // Start with the LoadingScreen
    );
  }
}
