import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/api_service.dart'; // Import the ApiService

class SensorDataScreen extends StatefulWidget {
  const SensorDataScreen({super.key});

  @override
  _SensorDataScreenState createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  List<dynamic> generalSensorData = [];
  List<dynamic> soilMoistureData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  Future<void> _fetchSensorData() async {
    // Fetch general sensor data
    final generalData = await ApiService.getSensorData();
    // Fetch soil moisture data
    final moistureData = await ApiService.getSensorData2();

    setState(() {
      if (generalData != null && generalData.containsKey('list')) {
        generalSensorData = generalData['list'];
      } else {
        generalSensorData = [];
      }

      if (moistureData != null && moistureData.containsKey('list')) {
        soilMoistureData = moistureData['list'];
      } else {
        soilMoistureData = [];
      }

      isLoading = false;
    });
  }

  List<FlSpot> _extractData(String key, List<dynamic> data) {
    return data
        .map<FlSpot>((entry) => FlSpot(
              DateTime.parse(entry['timestamp'])
                  .millisecondsSinceEpoch
                  .toDouble(),
              entry[key]?.toDouble() ?? 0.0,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (generalSensorData.isEmpty && soilMoistureData.isEmpty)
              ? const Center(
                  child: Text("No sensor data available."),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sensor Data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _SensorChart(
                        title: 'Temperature',
                        color: Colors.red,
                        data: _extractData('temperature', generalSensorData),
                        unit: '°C',
                      ),
                      const SizedBox(height: 24),
                      _SensorChart(
                        title: 'Humidity',
                        color: Colors.blue,
                        data: _extractData('humidity', generalSensorData),
                        unit: '%',
                      ),
                      const SizedBox(height: 24),
                      _SensorChart(
                        title: 'Light Intensity',
                        color: Colors.orange,
                        data: _extractData('lightIntensity', generalSensorData),
                        unit: '%',
                      ),
                      const SizedBox(height: 24),
                      _SensorChart(
                        title: 'Soil Moisture',
                        color: Colors.green,
                        data: _extractData('soilMoisture', soilMoistureData),
                        unit: '%',
                      ),
                    ],
                  ),
                ),
    );
  }
}

class _SensorChart extends StatelessWidget {
  final String title;
  final Color color;
  final List<FlSpot> data;
  final String unit;

  const _SensorChart({
    required this.title,
    required this.color,
    required this.data,
    required this.unit,
  });

  String _formatTimestamp(double timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
    return "${date.hour}:${date.minute}";
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _downloadCsv(title.toLowerCase(), data),
                  icon: const Icon(Icons.download),
                  label: const Text('Download CSV'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatTimestamp(value),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: data.isNotEmpty ? data.first.x : 0,
                  maxX: data.isNotEmpty ? data.last.x : 0,
                  minY: data.isNotEmpty
                      ? data.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 1
                      : 0,
                  maxY: data.isNotEmpty
                      ? data.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1
                      : 0,
                  lineBarsData: [
                    LineChartBarData(
                      spots: data,
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadCsv(String sensorType, List<FlSpot> data) {
    final csvContent = [
      'Timestamp,Value',
      ...data.map((point) => '${point.x},${point.y}'),
    ].join('\n');
    // Implement file download using `csvContent`.
    print('CSV content for $sensorType:\n$csvContent');
  }
}
