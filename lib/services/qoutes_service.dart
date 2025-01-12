import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mental_health_app/services/api_service.dart';

class QoutesService {
  final String _baseUrl =
      'http://10.0.2.2:8000/api'; // Ganti dengan URL API Anda
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchRandomQuote() async {
    final url = Uri.parse('$_baseUrl/random-quote');
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch screening results');
      }
    } catch (e) {
      throw Exception('Error fetching screening results: $e');
    }
  }
}
