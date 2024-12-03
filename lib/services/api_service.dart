import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000/api';

  // Fetch sensor data
  static Future<List<dynamic>> fetchSensorData() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // Add sensor data
  static Future<void> addSensorData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add data');
    }
  }
}
