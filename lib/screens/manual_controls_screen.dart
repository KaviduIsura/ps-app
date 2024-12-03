import 'package:flutter/material.dart';

class ManualControlsScreen extends StatefulWidget {
  const ManualControlsScreen({super.key});

  @override
  State<ManualControlsScreen> createState() => _ManualControlsScreenState();
}

class _ManualControlsScreenState extends State<ManualControlsScreen> {
  bool _fanPower = false;
  double _fanSpeed = 0;
  bool _lightingPower = false;
  double _lightingBrightness = 0;
  bool _irrigationPower = false;
  String _irrigationDuration = '5 minutes';
  double _targetTemperature = 18;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manual Controls',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _ControlCard(
            title: 'Fan Control',
            icon: Icons.air,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _fanPower,
                onChanged: (value) {
                  setState(() {
                    _fanPower = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Speed'),
              Slider(
                value: _fanSpeed,
                onChanged: (value) {
                  setState(() {
                    _fanSpeed = value;
                  });
                },
                label: '${(_fanSpeed * 100).round()}%',
                divisions: 10,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Lighting Control',
            icon: Icons.lightbulb,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _lightingPower,
                onChanged: (value) {
                  setState(() {
                    _lightingPower = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Brightness'),
              Slider(
                value: _lightingBrightness,
                onChanged: (value) {
                  setState(() {
                    _lightingBrightness = value;
                  });
                },
                label: '${(_lightingBrightness * 100).round()}%',
                divisions: 10,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Irrigation Control',
            icon: Icons.water_drop,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _irrigationPower,
                onChanged: (value) {
                  setState(() {
                    _irrigationPower = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Duration'),
              DropdownButton<String>(
                value: _irrigationDuration,
                onChanged: (String? newValue) {
                  setState(() {
                    _irrigationDuration = newValue!;
                  });
                },
                items: <String>[
                  '5 minutes',
                  '10 minutes',
                  '15 minutes',
                  '30 minutes'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Temperature Control',
            icon: Icons.thermostat,
            children: [
              const Text('Target Temperature'),
              Slider(
                value: _targetTemperature,
                min: 10,
                max: 30,
                divisions: 20,
                label: '${_targetTemperature.round()}°C',
                onChanged: (value) {
                  setState(() {
                    _targetTemperature = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ControlCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _ControlCard({
    required this.title,
    required this.icon,
    required this.children,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
