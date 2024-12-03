import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'sensor_data_screen.dart';
import 'manual_controls_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const SensorDataScreen(),
    const ManualControlsScreen(),
    const SettingsScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
        },
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32),
            ),
            child: Row(
              children: [
                Icon(Icons.eco, color: Colors.white, size: 32),
                SizedBox(width: 16),
                Text(
                  'GreenControl',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.data_usage),
            label: Text('Sensor Data'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.control_camera),
            label: Text('Manual Controls'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.info),
            label: Text('About'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('GreenControl'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _screens[_selectedIndex],
    );
  }
}
