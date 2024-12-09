import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://localhost:5003/api"; // Replace localhost with your actual backend URL

  // Fetch sensor data
  static Future<Map<String, dynamic>?> getSensorData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/sensor'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load sensor data: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching sensor data: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getSensorData2() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/sensor2'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load sensor data: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching sensor data: $e");
      return null;
    }
  }

  // Fetch control states
  static Future<Map<String, dynamic>?> getControlStates1() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/control'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load control states: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching control states: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getControlStates2() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/control2'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load control states: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching control states: $e");
      return null;
    }
  }
}
