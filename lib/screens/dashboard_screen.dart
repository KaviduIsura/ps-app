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
  Map<String, dynamic> _sensorData2 = {};
  Map<String, dynamic> _controlStates = {};
  Map<String, dynamic> _controlStates2 = {};
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
      // Fetch sensor data 1
      final sensorData = await ApiService.getSensorData();
      if (sensorData != null) {
        setState(() {
          _sensorData =
              sensorData['list'].isNotEmpty ? sensorData['list'].last : {};
        });
      }
      final sensorData2 = await ApiService.getSensorData2();
      if (sensorData2 != null) {
        setState(() {
          _sensorData2 =
              sensorData2['list'].isNotEmpty ? sensorData2['list'].last : {};
        });
      }

      // Fetch control states
      final controlStates = await ApiService.getControlStates1();
      if (controlStates != null) {
        setState(() {
          _controlStates = controlStates;
        });
      }

      final controlStates2 = await ApiService.getControlStates2();
      if (controlStates2 != null) {
        setState(() {
          _controlStates2 = controlStates2;
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
            textAlign: TextAlign.center, // Center the text horizontally
            style: TextStyle(
              fontSize: 26, // Increase font size for prominence
              fontWeight: FontWeight.bold, // Keep it bold for emphasis
              color: Colors.black87,
              // Change color for a fresh, nature-inspired look
              letterSpacing: 1, // Add some space between letters
              height: 1.5, // Adjust line height for better readability
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
                trend: '+2°C from yesterday',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Humidity',
                value:
                    '${_sensorData['humidity']?.toStringAsFixed(1) ?? 'N/A'}%',
                icon: Icons.water_drop,
                trend: '-5% from yesterday',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Light Intensity',
                value:
                    '${_sensorData['lightIntensity']?.toStringAsFixed(0) ?? 'N/A'} %',
                icon: Icons.light_mode,
                trend: 'Normal',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Soil Moisture',
                value:
                    '${_sensorData2['soilMoisture']?.toStringAsFixed(0) ?? 'N/A'} %', // Add this when you have soil moisture data
                icon: Icons.grass,
                trend: 'Optimal',
                trendPositive: true,
              ),
            ],
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'System Status',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SystemStatusTile(
                    title: 'Temperature Controller',
                    isActive: _controlStates['fan1'] ?? false,
                  ),
                  _SystemStatusTile(
                    title: 'Humidity Controller',
                    isActive: _controlStates['fan2'] ?? false,
                  ),
                  _SystemStatusTile(
                    title: 'Artificial Sunlight',
                    isActive: _controlStates['led'] ?? true,
                  ),
                  _SystemStatusTile(
                    title: 'Irrigation System',
                    isActive: _controlStates2['valve'] ?? false,
                  ),
                  _SystemStatusTile(
                    title: 'Motion Alert',
                    isActive: _controlStates2['led'] ?? false,
                  ),
                ],
              ),
            ),
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
