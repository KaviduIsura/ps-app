import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _minTemperature = 18;
  double _maxTemperature = 28;
  double _minHumidity = 60;
  double _maxHumidity = 80;
  double _minLightIntensity = 500;
  double _maxLightIntensity = 1000;
  double _minSoilMoisture = 30;
  double _maxSoilMoisture = 70;
  bool _darkMode = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _alertSounds = true;
  String _timeZone = 'UTC';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Threshold Configurations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _ThresholdSetting(
            title: 'Temperature',
            min: _minTemperature,
            max: _maxTemperature,
            unit: '°C',
            onMinChanged: (value) {
              setState(() {
                _minTemperature = value;
              });
            },
            onMaxChanged: (value) {
              setState(() {
                _maxTemperature = value;
              });
            },
          ),
          _ThresholdSetting(
            title: 'Humidity',
            min: _minHumidity,
            max: _maxHumidity,
            unit: '%',
            onMinChanged: (value) {
              setState(() {
                _minHumidity = value;
              });
            },
            onMaxChanged: (value) {
              setState(() {
                _maxHumidity = value;
              });
            },
          ),
          _ThresholdSetting(
            title: 'Light Intensity',
            min: _minLightIntensity,
            max: _maxLightIntensity,
            unit: 'lux',
            onMinChanged: (value) {
              setState(() {
                _minLightIntensity = value;
              });
            },
            onMaxChanged: (value) {
              setState(() {
                _maxLightIntensity = value;
              });
            },
          ),
          _ThresholdSetting(
            title: 'Soil Moisture',
            min: _minSoilMoisture,
            max: _maxSoilMoisture,
            unit: '%',
            onMinChanged: (value) {
              setState(() {
                _minSoilMoisture = value;
              });
            },
            onMaxChanged: (value) {
              setState(() {
                _maxSoilMoisture = value;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'User Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          const Text('Notifications'),
          SwitchListTile(
            title: const Text('Email Notifications'),
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Alert Sounds'),
            value: _alertSounds,
            onChanged: (value) {
              setState(() {
                _alertSounds = value;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text('Time Zone'),
          DropdownButton<String>(
            value: _timeZone,
            onChanged: (String? newValue) {
              setState(() {
                _timeZone = newValue!;
              });
            },
            items: <String>['UTC', 'GMT', 'EST', 'PST', 'CST']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement save changes functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Changes saved')),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

class _ThresholdSetting extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onMinChanged;
  final ValueChanged<double> onMaxChanged;

  const _ThresholdSetting({
    required this.title,
    required this.min,
    required this.max,
    required this.unit,
    required this.onMinChanged,
    required this.onMaxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Minimum'),
                  Slider(
                    value: min,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: min.round().toString(),
                    onChanged: onMinChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Maximum'),
                  Slider(
                    value: max,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: max.round().toString(),
                    onChanged: onMaxChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text('${min.round()} $unit - ${max.round()} $unit'),
        const SizedBox(height: 16),
      ],
    );
  }
}
