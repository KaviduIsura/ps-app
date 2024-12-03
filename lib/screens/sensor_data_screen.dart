import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorDataScreen extends StatelessWidget {
  const SensorDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            data: [
              FlSpot(0, 22),
              FlSpot(1, 23),
              FlSpot(2, 25),
              FlSpot(3, 24),
              FlSpot(4, 26),
              FlSpot(5, 25),
              FlSpot(6, 23),
            ],
            unit: '°C',
          ),
          const SizedBox(height: 24),
          _SensorChart(
            title: 'Humidity',
            color: Colors.blue,
            data: [
              FlSpot(0, 65),
              FlSpot(1, 68),
              FlSpot(2, 67),
              FlSpot(3, 69),
              FlSpot(4, 66),
              FlSpot(5, 70),
              FlSpot(6, 68),
            ],
            unit: '%',
          ),
          const SizedBox(height: 24),
          _SensorChart(
            title: 'Light Intensity',
            color: Colors.orange,
            data: [
              FlSpot(0, 800),
              FlSpot(1, 850),
              FlSpot(2, 900),
              FlSpot(3, 875),
              FlSpot(4, 925),
              FlSpot(5, 850),
              FlSpot(6, 875),
            ],
            unit: 'lux',
          ),
          const SizedBox(height: 24),
          _SensorChart(
            title: 'Air Flow',
            color: Colors.green,
            data: [
              FlSpot(0, 0.4),
              FlSpot(1, 0.5),
              FlSpot(2, 0.6),
              FlSpot(3, 0.5),
              FlSpot(4, 0.7),
              FlSpot(5, 0.6),
              FlSpot(6, 0.5),
            ],
            unit: 'm/s',
          ),
        ],
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
                  onPressed: () {
                    // TODO: Implement CSV download
                  },
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
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY:
                      data.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 1,
                  maxY:
                      data.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1,
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
}
