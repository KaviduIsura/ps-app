import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double? temperature;
  double? humidity;
  double? lightIntensity;
  bool fan1 = false;
  bool fan2 = false;
  bool led = false;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    // Fetch sensor data
    final sensorData = await ApiService.getSensorData();
    if (sensorData != null) {
      final latestData = sensorData['list'][0];
      setState(() {
        temperature = latestData['temperature'];
        humidity = latestData['humidity'];
        lightIntensity = latestData['lightIntensity'];
      });
    }

    // Fetch control states
    final controlStates = await ApiService.getControlStates();
    if (controlStates != null) {
      setState(() {
        fan1 = controlStates['fan1'] ?? false;
        fan2 = controlStates['fan2'] ?? false;
        led = controlStates['led'] ?? false;
      });
    }
  }

  String getStatusText(bool isActive) => isActive ? "Active" : "Standby";
  Color getStatusColor(bool isActive) =>
      isActive ? Colors.green : Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Greenhouse Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Greenhouse Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatCard(
                    title: "Temperature",
                    value: "${temperature ?? 'Loading...'}°C"),
                StatCard(
                    title: "Humidity", value: "${humidity ?? 'Loading...'}%"),
                StatCard(
                    title: "Light Intensity",
                    value: "${lightIntensity ?? 'Loading...'} lux"),
              ],
            ),
            SizedBox(height: 32),
            Text(
              "System Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Ventilation System (Fan 1)"),
              trailing: Chip(
                label: Text(getStatusText(fan1)),
                backgroundColor: getStatusColor(fan1),
              ),
            ),
            ListTile(
              title: Text("Irrigation System (Fan 2)"),
              trailing: Chip(
                label: Text(getStatusText(fan2)),
                backgroundColor: getStatusColor(fan2),
              ),
            ),
            ListTile(
              title: Text("Lighting System (LED)"),
              trailing: Chip(
                label: Text(getStatusText(led)),
                backgroundColor: getStatusColor(led),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
