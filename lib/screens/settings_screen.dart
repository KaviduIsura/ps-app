import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Threshold Configurations Section (Large Card)
            const SectionHeader(title: "Threshold Configurations"),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThresholdCard(
                      title: "Temperature",
                      minController: TextEditingController(text: '18'),
                      maxController: TextEditingController(text: '28'),
                      unit: "°C",
                    ),
                    const SizedBox(height: 16),
                    ThresholdCard(
                      title: "Humidity",
                      minController: TextEditingController(text: '60'),
                      maxController: TextEditingController(text: '80'),
                      unit: "%",
                    ),
                    const SizedBox(height: 16),
                    ThresholdCard(
                      title: "Light Intensity",
                      minController: TextEditingController(text: '500'),
                      maxController: TextEditingController(text: '1000'),
                      unit: "lux",
                    ),
                    const SizedBox(height: 16),
                    ThresholdCard(
                      title: "Soil Moisture",
                      minController: TextEditingController(text: '30'),
                      maxController: TextEditingController(text: '70'),
                      unit: "%",
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Save logic can be added here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30), // Space between sections

            // User Preferences Section
            const SectionHeader(title: "User Preferences"),
            UserPreferences(),
            const SizedBox(height: 30), // Space between sections

            // Device Management Section
            const SectionHeader(title: "Device Management"),
            DeviceManagement(),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ThresholdCard extends StatelessWidget {
  final String title;
  final TextEditingController minController;
  final TextEditingController maxController;
  final String unit;

  const ThresholdCard({
    required this.title,
    required this.minController,
    required this.maxController,
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: const Text("Min")),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Min',
                      suffixText: unit,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: const Text("Max")),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Max',
                      suffixText: unit,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchRow(label: "Dark Mode", value: false),
        SwitchRow(label: "Email Notifications", value: true),
        SwitchRow(label: "Push Notifications", value: true),
        SwitchRow(label: "Alert Sounds", value: true),
        DropdownButton<String>(
          isExpanded: true,
          value: "UTC",
          items: ["UTC", "GMT", "EST"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ],
    );
  }
}

class SwitchRow extends StatelessWidget {
  final String label;
  final bool value;

  const SwitchRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Switch(value: value, onChanged: (bool newValue) {}),
        ],
      ),
    );
  }
}

class DeviceManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DeviceTile(
            deviceName: "Temperature Sensor 1",
            deviceType: "temperature",
            status: "online"),
        DeviceTile(
            deviceName: "Humidity Sensor 1",
            deviceType: "humidity",
            status: "online"),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Add Device"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ],
    );
  }
}

class DeviceTile extends StatelessWidget {
  final String deviceName;
  final String deviceType;
  final String status;

  const DeviceTile({
    required this.deviceName,
    required this.deviceType,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(deviceName),
        subtitle: Text("Type: $deviceType"),
        trailing: Text(
          status,
          style:
              const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
