import 'package:flutter/material.dart';
import 'dart:async';
import '../services/api_service.dart'; // Import your ApiService class

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> _sensorData = {};
  Map<String, dynamic> _controlStates = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchData();
    // Set up a timer to fetch data every 5 seconds
    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => _fetchData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch sensor data
      final sensorData = await ApiService.getSensorData();
      if (sensorData != null) {
        setState(() {
          _sensorData =
              sensorData['list'].isNotEmpty ? sensorData['list'].last : {};
        });
      }

      // Fetch control states
      final controlStates = await ApiService.getControlStates1();
      if (controlStates != null) {
        setState(() {
          _controlStates = controlStates;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Greenhouse Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _MetricCard(
                title: 'Temperature',
                value:
                    '${_sensorData['temperature']?.toStringAsFixed(1) ?? 'N/A'}°C',
                icon: Icons.thermostat,
                trend: 'Live Data',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Humidity',
                value:
                    '${_sensorData['humidity']?.toStringAsFixed(1) ?? 'N/A'}%',
                icon: Icons.water_drop,
                trend: 'Live Data',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Light Intensity',
                value:
                    '${_sensorData['lightIntensity']?.toStringAsFixed(0) ?? 'N/A'} lux',
                icon: Icons.light_mode,
                trend: 'Live Data',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Soil Moisture',
                value: 'N/A', // Add this when you have soil moisture data
                icon: Icons.grass,
                trend: 'Live Data',
                trendPositive: true,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'System Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _SystemStatusTile(
            title: 'Ventilation System (Fan 1)',
            isActive: _controlStates['fan1'] ?? false,
          ),
          _SystemStatusTile(
            title: 'Irrigation System (Fan 2)',
            isActive: _controlStates['fan2'] ?? false,
          ),
          _SystemStatusTile(
            title: 'Lighting System (LED)',
            isActive: _controlStates['led'] ?? false,
          ),
          _SystemStatusTile(
            title: 'Climate Control',
            isActive: true,
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final bool trendPositive;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.trendPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              trend,
              style: TextStyle(
                fontSize: 12,
                color: trendPositive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SystemStatusTile extends StatelessWidget {
  final String title;
  final bool isActive;
  final String? status;

  const _SystemStatusTile({
    required this.title,
    required this.isActive,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Chip(
        label: Text(
          status ?? (isActive ? 'Active' : 'Inactive'),
          style: TextStyle(
            color: isActive ? Colors.green : Colors.orange,
          ),
        ),
        backgroundColor: isActive
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
      ),
    );
  }
}
