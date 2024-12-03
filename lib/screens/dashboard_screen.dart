import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                value: '24°C',
                icon: Icons.thermostat,
                trend: '+2°C from yesterday',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Humidity',
                value: '65%',
                icon: Icons.water_drop,
                trend: '-5% from yesterday',
                trendPositive: false,
              ),
              _MetricCard(
                title: 'Light Intensity',
                value: '850 lux',
                icon: Icons.light_mode,
                trend: 'Normal',
                trendPositive: true,
              ),
              _MetricCard(
                title: 'Air Flow',
                value: '0.5 m/s',
                icon: Icons.air,
                trend: 'Optimal',
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
            title: 'Ventilation System',
            isActive: true,
          ),
          _SystemStatusTile(
            title: 'Irrigation System',
            isActive: false,
            status: 'Standby',
          ),
          _SystemStatusTile(
            title: 'Lighting System',
            isActive: true,
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
