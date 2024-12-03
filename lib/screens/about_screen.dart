import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About GreenControl',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'GreenControl is an advanced greenhouse management system designed to help you monitor and control your greenhouse environment efficiently.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Features:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _FeatureItem(
            icon: Icons.dashboard,
            text: 'Real-time dashboard for quick overview',
          ),
          _FeatureItem(
            icon: Icons.sensors,
            text: 'Detailed sensor data and historical trends',
          ),
          _FeatureItem(
            icon: Icons.control_camera,
            text: 'Manual controls for fine-tuning your greenhouse',
          ),
          _FeatureItem(
            icon: Icons.settings,
            text: 'Customizable settings and thresholds',
          ),
          const SizedBox(height: 16),
          const Text(
            'Version: 1.0.0',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          const Text(
            '© 2024 GreenControl. All rights reserved.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
