import 'package:flutter/material.dart';

class ManualControlsScreen extends StatefulWidget {
  const ManualControlsScreen({super.key});

  @override
  State<ManualControlsScreen> createState() => _ManualControlsScreenState();
}

class _ManualControlsScreenState extends State<ManualControlsScreen> {
  bool _humiFan = false;
  bool _lighting = false;
  bool _irrigation = false;
  bool _tepmFan = false;

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
                value: _humiFan,
                onChanged: (value) {
                  setState(() {
                    _humiFan = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Speed'),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Lighting Control',
            icon: Icons.lightbulb,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _lighting,
                onChanged: (value) {
                  setState(() {
                    _lighting = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Brightness'),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Irrigation Control',
            icon: Icons.water_drop,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _irrigation,
                onChanged: (value) {
                  setState(() {
                    _irrigation = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              const Text('Duration'),
            ],
          ),
          const SizedBox(height: 16),
          _ControlCard(
            title: 'Temperature Control',
            icon: Icons.thermostat,
            children: [
              SwitchListTile(
                title: const Text('Power'),
                value: _tepmFan,
                onChanged: (value) {
                  setState(() {
                    _tepmFan = value;
                  });
                },
              )
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
