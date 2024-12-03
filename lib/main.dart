import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GreenControlApp());
}

class GreenControlApp extends StatelessWidget {
  const GreenControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenControl',
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
