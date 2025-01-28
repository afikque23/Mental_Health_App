import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mental_health_app/services/api_service.dart';

class ScreeningService {
  final String _baseUrl =
      'https://mentalhealth.cyou/api'; // Ganti dengan URL API Anda
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getScreeningResults(int userId) async {
    final String url = '$_baseUrl/screening-results/$userId';
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json', // Ganti dengan token autentikasi
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['results'] ?? [];
      } else {
        throw Exception('Failed to fetch screening results');
      }
    } catch (e) {
      throw Exception('Error fetching screening results: $e');
    }
  }

  Future<List<dynamic>> getFilteredScreening(String filter, int userId) async {
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/filterd-screening?&filter=$filter&id_user=$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        return data;
      } else {
        throw Exception('Failed to load mood trackers');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
